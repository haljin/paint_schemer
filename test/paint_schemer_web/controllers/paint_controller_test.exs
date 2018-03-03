defmodule PaintSchemerWeb.PaintControllerTest do
  use PaintSchemerWeb.ConnCase

  alias PaintSchemer.Paints
  alias PaintSchemer.Paints.Paint

  @create_attrs %{color: <<15, 12, 12>>, name: "some name"}
  @update_attrs %{color: <<16, 12, 12>>, name: "some updated name"}
  @invalid_attrs %{color: nil, name: nil}

  def fixture(:paint) do
    {:ok, type} = Paints.create_paint_type(%{name: "Some paint type"})
    {:ok, manufacturer} = Paints.create_manufacturer(%{name: "Some manufacturer"})
    {:ok, paint} =
      @create_attrs
      |> Map.merge(%{type_id: type.id, manufacturer_id: manufacturer.id})
      |> Paints.create_paint
    paint
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all paints", %{conn: conn} do
      conn = get conn, paint_path(conn, :index)
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create paint" do
    test "renders paint when data is valid", %{conn: conn} do
      {:ok, type} = Paints.create_paint_type(%{name: "Some paint type"})
      {:ok, manufacturer} = Paints.create_manufacturer(%{name: "Some manufacturer"})
      attrs =
        @create_attrs
        |> Map.merge(%{type_id: type.id, manufacturer_id: manufacturer.id})

      conn = post conn, paint_path(conn, :create), data: attrs
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get conn, paint_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "manufacturer" => "Some manufacturer",
        "type" => "Some paint type",
        "color" => "#0F0C0C",
        "name" => "some name"}
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, paint_path(conn, :create), data: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update paint" do
    setup [:create_paint]

    test "renders paint when data is valid", %{conn: conn, paint: %Paint{id: id} = paint} do
      conn = put conn, paint_path(conn, :update, paint), data: @update_attrs
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get conn, paint_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "manufacturer" => "Some manufacturer",
        "type" => "Some paint type",
        "color" => "#100C0C",
        "name" => "some updated name"}
    end

    test "renders errors when data is invalid", %{conn: conn, paint: paint} do
      conn = put conn, paint_path(conn, :update, paint), data: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete paint" do
    setup [:create_paint]

    test "deletes chosen paint", %{conn: conn, paint: paint} do
      conn = delete conn, paint_path(conn, :delete, paint)
      assert response(conn, 204)
      assert_error_sent 404, fn ->
        get conn, paint_path(conn, :show, paint)
      end
    end
  end

  defp create_paint(_) do
    paint = fixture(:paint)
    {:ok, paint: paint}
  end
end
