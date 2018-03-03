defmodule PaintSchemerWeb.ManufacturerControllerTest do
  use PaintSchemerWeb.ConnCase

  alias PaintSchemer.Paints
  alias PaintSchemer.Paints.Manufacturer

  @create_attrs %{name: "some name"}
  @update_attrs %{name: "some updated name"}
  @invalid_attrs %{name: nil}

  def fixture(:manufacturer) do
    {:ok, manufacturer} = Paints.create_manufacturer(@create_attrs)
    manufacturer
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all paint_manufacturers", %{conn: conn} do
      conn = get conn, manufacturer_path(conn, :index)
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create manufacturer" do
    test "renders manufacturer when data is valid", %{conn: conn} do
      conn = post conn, manufacturer_path(conn, :create), data: @create_attrs
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get conn, manufacturer_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "name" => "some name"}
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, manufacturer_path(conn, :create), data: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update manufacturer" do
    setup [:create_manufacturer]

    test "renders manufacturer when data is valid", %{conn: conn, manufacturer: %Manufacturer{id: id} = manufacturer} do
      conn = put conn, manufacturer_path(conn, :update, manufacturer), data: @update_attrs
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get conn, manufacturer_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "name" => "some updated name"}
    end

    test "renders errors when data is invalid", %{conn: conn, manufacturer: manufacturer} do
      conn = put conn, manufacturer_path(conn, :update, manufacturer), data: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete manufacturer" do
    setup [:create_manufacturer]

    test "deletes chosen manufacturer", %{conn: conn, manufacturer: manufacturer} do
      conn = delete conn, manufacturer_path(conn, :delete, manufacturer)
      assert response(conn, 204)
      assert_error_sent 404, fn ->
        get conn, manufacturer_path(conn, :show, manufacturer)
      end
    end
  end

  defp create_manufacturer(_) do
    manufacturer = fixture(:manufacturer)
    {:ok, manufacturer: manufacturer}
  end
end
