defmodule PaintSchemerWeb.PaintController do
  use PaintSchemerWeb, :controller

  alias PaintSchemer.Paints
  alias PaintSchemer.Paints.Paint

  action_fallback PaintSchemerWeb.FallbackController

  def index(conn, _params) do
    paints = Paints.list_paints()
    render(conn, "index.json", paints: paints)
  end

  def create(conn, %{"paint" => paint_params}) do
    with {:ok, %Paint{} = paint} <- Paints.create_paint(paint_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", paint_path(conn, :show, paint))
      |> render("show.json", paint: paint)
    end
  end

  def show(conn, %{"id" => id}) do
    paint = Paints.get_paint!(id)
    render(conn, "show.json", paint: paint)
  end

  def update(conn, %{"id" => id, "paint" => paint_params}) do
    paint = Paints.get_paint!(id)

    with {:ok, %Paint{} = paint} <- Paints.update_paint(paint, paint_params) do
      render(conn, "show.json", paint: paint)
    end
  end

  def delete(conn, %{"id" => id}) do
    paint = Paints.get_paint!(id)
    with {:ok, %Paint{}} <- Paints.delete_paint(paint) do
      send_resp(conn, :no_content, "")
    end
  end
end