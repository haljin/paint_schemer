defmodule PaintSchemerWeb.PaintTechniqueController do
  use PaintSchemerWeb, :controller

  alias PaintSchemer.Paints
  alias PaintSchemer.Paints.PaintTechnique

  action_fallback(PaintSchemerWeb.FallbackController)

  def index(conn, _params) do
    paint_technique = Paints.list_paint_technique()
    render(conn, "index.json", paint_technique: paint_technique)
  end

  def create(conn, %{"data" => paint_technique_params}) do
    with {:ok, %PaintTechnique{} = paint_technique} <- Paints.create_paint_technique(paint_technique_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", paint_technique_path(conn, :show, paint_technique))
      |> render("show.json", paint_technique: paint_technique)
    end
  end

  def show(conn, %{"id" => id}) do
    paint_technique = Paints.get_paint_technique!(id)
    render(conn, "show.json", paint_technique: paint_technique)
  end

  def delete(conn, %{"id" => id}) do
    paint_technique = Paints.get_paint_technique!(id)

    with {:ok, %PaintTechnique{}} <- Paints.delete_paint_technique(paint_technique) do
      send_resp(conn, :no_content, "")
    end
  end
end
