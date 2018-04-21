defmodule PaintSchemerWeb.PaintMixControllerTest do
  use PaintSchemerWeb.ConnCase

  alias PaintSchemer.Paints
  alias PaintSchemer.Schemes
  alias PaintSchemer.Schemes.PaintMix

  @create_attrs %{ratio: 42}
  @update_attrs %{ratio: 43}
  @invalid_attrs %{ratio: nil}

  def fixture(:paint_mix) do
    {:ok, type} = Paints.create_paint_type(%{name: "Some paint type"})
    {:ok, manufacturer} = Paints.create_manufacturer(%{name: "Some manufacturer"})
    {:ok, paint} = Paints.create_paint(%{color: <<12, 12, 12>>, name: "Some paint", manufacturer_id: manufacturer.id, type_id: type.id})
    {:ok, technique} = Paints.create_paint_technique(%{name: "Some technique"})

    {:ok, scheme} = Schemes.create_scheme(%{title: "Some scheme"})
    {:ok, section} = Schemes.create_section(%{scheme_id: scheme.id})
    {:ok, step} = Schemes.create_step(%{ordering: 1, section_id: section.id, paint_technique_id: technique.id})
    {:ok, paint_mix} =
      @create_attrs
      |> Map.merge(%{paint_id: paint.id, step_id: step.id})
      |> Schemes.create_paint_mix()
    paint_mix
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all scheme_mixes", %{conn: conn} do
      conn = get conn, paint_mix_path(conn, :index)
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create paint_mix" do
    test "renders paint_mix when data is valid", %{conn: conn} do
      {:ok, type} = Paints.create_paint_type(%{name: "Some paint type"})
      {:ok, manufacturer} = Paints.create_manufacturer(%{name: "Some manufacturer"})
      {:ok, paint} = Paints.create_paint(%{color: <<12, 12, 12>>, name: "Some paint", manufacturer_id: manufacturer.id, type_id: type.id})
      {:ok, technique} = Paints.create_paint_technique(%{name: "Some technique"})

      {:ok, scheme} = Schemes.create_scheme(%{title: "Some scheme"})
      {:ok, section} = Schemes.create_section(%{scheme_id: scheme.id})
      {:ok, step} = Schemes.create_step(%{ordering: 1, section_id: section.id, paint_technique_id: technique.id})
      attrs =
        @create_attrs
        |> Map.merge(%{paint_id: paint.id, step_id: step.id})

      conn = post conn, paint_mix_path(conn, :create), paint_mix: attrs
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get conn, paint_mix_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "ratio" => 42}
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, paint_mix_path(conn, :create), paint_mix: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update paint_mix" do
    setup [:create_paint_mix]

    test "renders paint_mix when data is valid", %{conn: conn, paint_mix: %PaintMix{id: id} = paint_mix} do
      conn = put conn, paint_mix_path(conn, :update, paint_mix), paint_mix: @update_attrs
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get conn, paint_mix_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "ratio" => 43}
    end

    test "renders errors when data is invalid", %{conn: conn, paint_mix: paint_mix} do
      conn = put conn, paint_mix_path(conn, :update, paint_mix), paint_mix: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete paint_mix" do
    setup [:create_paint_mix]

    test "deletes chosen paint_mix", %{conn: conn, paint_mix: paint_mix} do
      conn = delete conn, paint_mix_path(conn, :delete, paint_mix)
      assert response(conn, 204)
      assert_error_sent 404, fn ->
        get conn, paint_mix_path(conn, :show, paint_mix)
      end
    end
  end

  defp create_paint_mix(_) do
    paint_mix = fixture(:paint_mix)
    {:ok, paint_mix: paint_mix}
  end
end
