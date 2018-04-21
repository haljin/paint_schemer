defmodule PaintSchemerWeb.SectionsControllerTest do
  use PaintSchemerWeb.ConnCase

  alias PaintSchemer.Schemes
  alias PaintSchemer.Schemes.Sections

  @create_attrs %{ordering: 42}
  @update_attrs %{ordering: 43}
  @invalid_attrs %{ordering: nil}

  def fixture(:sections) do
    {:ok, sections} = Schemes.create_sections(@create_attrs)
    sections
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all scheme_sections", %{conn: conn} do
      conn = get conn, sections_path(conn, :index)
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create sections" do
    test "renders sections when data is valid", %{conn: conn} do
      conn = post conn, sections_path(conn, :create), sections: @create_attrs
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get conn, sections_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "ordering" => 42}
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, sections_path(conn, :create), sections: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update sections" do
    setup [:create_sections]

    test "renders sections when data is valid", %{conn: conn, sections: %Sections{id: id} = sections} do
      conn = put conn, sections_path(conn, :update, sections), sections: @update_attrs
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get conn, sections_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "ordering" => 43}
    end

    test "renders errors when data is invalid", %{conn: conn, sections: sections} do
      conn = put conn, sections_path(conn, :update, sections), sections: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete sections" do
    setup [:create_sections]

    test "deletes chosen sections", %{conn: conn, sections: sections} do
      conn = delete conn, sections_path(conn, :delete, sections)
      assert response(conn, 204)
      assert_error_sent 404, fn ->
        get conn, sections_path(conn, :show, sections)
      end
    end
  end

  defp create_sections(_) do
    sections = fixture(:sections)
    {:ok, sections: sections}
  end
end
