defmodule PaintSchemerWeb.PaintTechniqueControllerTest do
  use PaintSchemerWeb.ConnCase

  alias PaintSchemer.Paints

  @create_attrs %{name: "some name"}
  @invalid_attrs %{name: nil}

  def fixture(:paint_technique) do
    {:ok, paint_technique} = Paints.create_paint_technique(@create_attrs)
    paint_technique
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all paint_technique", %{conn: conn} do
      conn = get(conn, paint_technique_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create paint_technique" do
    test "renders paint_technique when data is valid", %{conn: conn} do
      conn = post(conn, paint_technique_path(conn, :create), data: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, paint_technique_path(conn, :show, id))
      assert json_response(conn, 200)["data"] == %{"id" => id, "name" => "some name"}
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, paint_technique_path(conn, :create), data: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete paint_technique" do
    setup [:create_paint_technique]

    test "deletes chosen paint_technique", %{conn: conn, paint_technique: paint_technique} do
      conn = delete(conn, paint_technique_path(conn, :delete, paint_technique))
      assert response(conn, 204)

      assert_error_sent(404, fn ->
        get(conn, paint_technique_path(conn, :show, paint_technique))
      end)
    end
  end

  defp create_paint_technique(_) do
    paint_technique = fixture(:paint_technique)
    {:ok, paint_technique: paint_technique}
  end
end
