defmodule PaintSchemerWeb.Scheme.ViewController do
  use PaintSchemerWeb, :controller

  alias PaintSchemer.Schemes
  alias PaintSchemerWeb.ErrorView

  def index(conn, params) do
    case Schemes.get_scheme(params["id"]) do
      nil ->
        conn
        |> put_status(:not_found)
        |> render(ErrorView, :"404")

      _ ->
        render(conn, "index.html", %{scheme: params["id"]})
    end
  end
end
