defmodule PaintSchemerWeb.StepsControllerTest do
  use PaintSchemerWeb.ConnCase

  alias PaintSchemer.Schemes
  alias PaintSchemer.Schemes.Steps

  @create_attrs %{ordering: 42}
  @update_attrs %{ordering: 43}
  @invalid_attrs %{ordering: nil}

  def fixture(:steps) do
    {:ok, steps} = Schemes.create_steps(@create_attrs)
    steps
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all scheme_steps", %{conn: conn} do
      conn = get conn, steps_path(conn, :index)
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create steps" do
    test "renders steps when data is valid", %{conn: conn} do
      conn = post conn, steps_path(conn, :create), steps: @create_attrs
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get conn, steps_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "ordering" => 42}
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, steps_path(conn, :create), steps: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update steps" do
    setup [:create_steps]

    test "renders steps when data is valid", %{conn: conn, steps: %Steps{id: id} = steps} do
      conn = put conn, steps_path(conn, :update, steps), steps: @update_attrs
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get conn, steps_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "ordering" => 43}
    end

    test "renders errors when data is invalid", %{conn: conn, steps: steps} do
      conn = put conn, steps_path(conn, :update, steps), steps: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete steps" do
    setup [:create_steps]

    test "deletes chosen steps", %{conn: conn, steps: steps} do
      conn = delete conn, steps_path(conn, :delete, steps)
      assert response(conn, 204)
      assert_error_sent 404, fn ->
        get conn, steps_path(conn, :show, steps)
      end
    end
  end

  defp create_steps(_) do
    steps = fixture(:steps)
    {:ok, steps: steps}
  end
end
