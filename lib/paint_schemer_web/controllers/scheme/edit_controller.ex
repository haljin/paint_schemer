defmodule PaintSchemerWeb.Scheme.EditController do
  use PaintSchemerWeb, :controller

  def index(conn, params) do
    case PaintSchemer.Schemes.get_scheme(params["id"]) do
      nil ->
        conn
        |> put_status(:not_found)
        |> render(PaintSchemerWeb.ErrorView, :"404")

      _ ->
        render(conn, "index.html", %{scheme: params["id"]})
    end
  end
end
