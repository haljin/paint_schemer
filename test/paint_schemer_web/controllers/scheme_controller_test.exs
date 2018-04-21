defmodule PaintSchemerWeb.SchemeControllerTest do
  use PaintSchemerWeb.ConnCase

  alias PaintSchemer.Schemes
  alias PaintSchemer.Schemes.Scheme

  @create_attrs %{description: "some description", image_url: "some image_url", title: "some title"}
  @update_attrs %{description: "some updated description", image_url: "some updated image_url", title: "some updated title"}
  @invalid_attrs %{description: nil, image_url: nil, title: nil}

  def fixture(:scheme) do
    {:ok, scheme} = Schemes.create_scheme(@create_attrs)
    scheme
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all schemes", %{conn: conn} do
      conn = get conn, scheme_path(conn, :index)
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create scheme" do
    test "renders scheme when data is valid", %{conn: conn} do
      conn = post conn, scheme_path(conn, :create), scheme: @create_attrs
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get conn, scheme_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "description" => "some description",
        "image_url" => "some image_url",
        "title" => "some title"}
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, scheme_path(conn, :create), scheme: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update scheme" do
    setup [:create_scheme]

    test "renders scheme when data is valid", %{conn: conn, scheme: %Scheme{id: id} = scheme} do
      conn = put conn, scheme_path(conn, :update, scheme), scheme: @update_attrs
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get conn, scheme_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "description" => "some updated description",
        "image_url" => "some updated image_url",
        "title" => "some updated title"}
    end

    test "renders errors when data is invalid", %{conn: conn, scheme: scheme} do
      conn = put conn, scheme_path(conn, :update, scheme), scheme: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete scheme" do
    setup [:create_scheme]

    test "deletes chosen scheme", %{conn: conn, scheme: scheme} do
      conn = delete conn, scheme_path(conn, :delete, scheme)
      assert response(conn, 204)
      assert_error_sent 404, fn ->
        get conn, scheme_path(conn, :show, scheme)
      end
    end
  end

  defp create_scheme(_) do
    scheme = fixture(:scheme)
    {:ok, scheme: scheme}
  end
end
