defmodule PaintSchemerWeb.PaintControllerTest do
  use PaintSchemerWeb.ConnCase

  alias PaintSchemer.Paints

  @create_attrs %{color: <<12, 12, 12>>, name: "some name"}
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
        |> Map.merge(%{type_id: type.id, manufacturer_id: manufacturer.id, color: "#0F0C0C"})

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
      assert json_response(conn, 422)
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
