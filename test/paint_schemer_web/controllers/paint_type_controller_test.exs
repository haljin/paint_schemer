defmodule PaintSchemerWeb.PaintTypeControllerTest do
  use PaintSchemerWeb.ConnCase

  alias PaintSchemer.Paints
  alias PaintSchemer.Paints.PaintType

  @create_attrs %{name: "some name"}
  @update_attrs %{name: "some updated name"}
  @invalid_attrs %{name: nil}

  def fixture(:paint_type) do
    {:ok, paint_type} = Paints.create_paint_type(@create_attrs)
    paint_type
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all paint_types", %{conn: conn} do
      conn = get conn, paint_type_path(conn, :index)
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create paint_type" do
    test "renders paint_type when data is valid", %{conn: conn} do
      conn = post conn, paint_type_path(conn, :create), data: @create_attrs
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get conn, paint_type_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "name" => "some name"}
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, paint_type_path(conn, :create), data: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update paint_type" do
    setup [:create_paint_type]

    test "renders paint_type when data is valid", %{conn: conn, paint_type: %PaintType{id: id} = paint_type} do
      conn = put conn, paint_type_path(conn, :update, paint_type), data: @update_attrs
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get conn, paint_type_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "name" => "some updated name"}
    end

    test "renders errors when data is invalid", %{conn: conn, paint_type: paint_type} do
      conn = put conn, paint_type_path(conn, :update, paint_type), data: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete paint_type" do
    setup [:create_paint_type]

    test "deletes chosen paint_type", %{conn: conn, paint_type: paint_type} do
      conn = delete conn, paint_type_path(conn, :delete, paint_type)
      assert response(conn, 204)
      assert_error_sent 404, fn ->
        get conn, paint_type_path(conn, :show, paint_type)
      end
    end
  end

  defp create_paint_type(_) do
    paint_type = fixture(:paint_type)
    {:ok, paint_type: paint_type}
  end
end
