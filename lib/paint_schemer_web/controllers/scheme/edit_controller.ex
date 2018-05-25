defmodule PaintSchemerWeb.Scheme.EditController do
  use PaintSchemerWeb, :controller

  def index(conn, params) do
    render(conn, "index.html", %{scheme: params["id"]})
  end
end
