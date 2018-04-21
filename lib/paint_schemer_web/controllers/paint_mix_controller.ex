defmodule PaintSchemerWeb.PaintMixController do
  use PaintSchemerWeb, :controller

  alias PaintSchemer.Schemes
  alias PaintSchemer.Schemes.PaintMix

  action_fallback PaintSchemerWeb.FallbackController

  def index(conn, _params) do
    scheme_mixes = Schemes.list_scheme_mixes()
    render(conn, "index.json", scheme_mixes: scheme_mixes)
  end

  def create(conn, %{"paint_mix" => paint_mix_params}) do
    with {:ok, %PaintMix{} = paint_mix} <- Schemes.create_paint_mix(paint_mix_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", paint_mix_path(conn, :show, paint_mix))
      |> render("show.json", paint_mix: paint_mix)
    end
  end

  def show(conn, %{"id" => id}) do
    paint_mix = Schemes.get_paint_mix!(id)
    render(conn, "show.json", paint_mix: paint_mix)
  end

  def update(conn, %{"id" => id, "paint_mix" => paint_mix_params}) do
    paint_mix = Schemes.get_paint_mix!(id)

    with {:ok, %PaintMix{} = paint_mix} <- Schemes.update_paint_mix(paint_mix, paint_mix_params) do
      render(conn, "show.json", paint_mix: paint_mix)
    end
  end

  def delete(conn, %{"id" => id}) do
    paint_mix = Schemes.get_paint_mix!(id)
    with {:ok, %PaintMix{}} <- Schemes.delete_paint_mix(paint_mix) do
      send_resp(conn, :no_content, "")
    end
  end
end
