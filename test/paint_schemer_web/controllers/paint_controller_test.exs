defmodule PaintSchemerWeb.PaintControllerTest do
  use PaintSchemerWeb.ConnCase

  alias PaintSchemer.Paints
  alias PaintSchemer.Paints.Paint

  @create_attrs %{color: "some color", name: "some name"}
  @update_attrs %{color: "some updated color", name: "some updated name"}
  @invalid_attrs %{color: nil, name: nil}

  def fixture(:paint) do
    {:ok, paint} = Paints.create_paint(@create_attrs)
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
      conn = post conn, paint_path(conn, :create), paint: @create_attrs
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get conn, paint_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "color" => "some color",
        "name" => "some name"}
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, paint_path(conn, :create), paint: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update paint" do
    setup [:create_paint]

    test "renders paint when data is valid", %{conn: conn, paint: %Paint{id: id} = paint} do
      conn = put conn, paint_path(conn, :update, paint), paint: @update_attrs
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get conn, paint_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "color" => "some updated color",
        "name" => "some updated name"}
    end

    test "renders errors when data is invalid", %{conn: conn, paint: paint} do
      conn = put conn, paint_path(conn, :update, paint), paint: @invalid_attrs
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