defmodule PaintSchemerWeb.PaintController do
  use PaintSchemerWeb, :controller

  alias PaintSchemer.Paints
  alias PaintSchemer.Paints.Paint

  action_fallback(PaintSchemerWeb.FallbackController)

  def index(conn, _params) do
    paints = Paints.list_paints()
    render(conn, "index.json", paints: paints)
  end

  def create(conn, %{"data" => paint_params}) do
    with {:ok, converted_color_params} <- convert_color(paint_params),
         {:ok, %Paint{} = paint} <- Paints.create_paint(converted_color_params) do
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

  def delete(conn, %{"id" => id}) do
    paint = Paints.get_paint!(id)

    with {:ok, %Paint{}} <- Paints.delete_paint(paint) do
      send_resp(conn, :no_content, "")
    end
  end

  defp convert_color(paint_params) do
    with "#" <> color_hex <- paint_params["color"],
         color_hex = String.upcase(color_hex),
         {:ok, color_binary} <- Base.decode16(color_hex),
         converted_color_params = %{paint_params | "color" => color_binary} do
      {:ok, converted_color_params}
    else
      _ -> {:error, :bad_input}
    end
  end
end
