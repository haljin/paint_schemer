defmodule PaintSchemerWeb.StepControllerTest do
  use PaintSchemerWeb.ConnCase

  alias PaintSchemer.Paints
  alias PaintSchemer.Schemes
  alias PaintSchemer.Schemes.Step

  @create_attrs %{ordering: 42}
  @update_attrs %{ordering: 43}
  @invalid_attrs %{ordering: nil}

  def fixture(:step) do
    {:ok, scheme} = Schemes.create_scheme(%{title: "Some scheme"})
    {:ok, technique} = Paints.create_paint_technique(%{name: "Some technique"})
    {:ok, section} = Schemes.create_section(%{scheme_id: scheme.id})
    {:ok, step} =
      @create_attrs
      |> Map.merge(%{paint_technique_id: technique.id, section_id: section.id})
      |> Schemes.create_step()
    step
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all scheme_step", %{conn: conn} do
      conn = get conn, step_path(conn, :index)
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create step" do
    test "renders step when data is valid", %{conn: conn} do
      {:ok, scheme} = Schemes.create_scheme(%{title: "Some scheme"})
      {:ok, technique} = Paints.create_paint_technique(%{name: "Some technique"})
      {:ok, section} = Schemes.create_section(%{scheme_id: scheme.id})
      attrs =
        @create_attrs
        |> Map.merge(%{paint_technique_id: technique.id, section_id: section.id})

      conn = post conn, step_path(conn, :create), step: attrs
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get conn, step_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "ordering" => 42}
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, step_path(conn, :create), step: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update step" do
    setup [:create_step]

    test "renders step when data is valid", %{conn: conn, step: %Step{id: id} = step} do
      conn = put conn, step_path(conn, :update, step), step: @update_attrs
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get conn, step_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "ordering" => 43}
    end

    test "renders errors when data is invalid", %{conn: conn, step: step} do
      conn = put conn, step_path(conn, :update, step), step: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete step" do
    setup [:create_step]

    test "deletes chosen step", %{conn: conn, step: step} do
      conn = delete conn, step_path(conn, :delete, step)
      assert response(conn, 204)
      assert_error_sent 404, fn ->
        get conn, step_path(conn, :show, step)
      end
    end
  end

  defp create_step(_) do
    step = fixture(:step)
    {:ok, step: step}
  end
end
