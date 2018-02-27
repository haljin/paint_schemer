defmodule PaintSchemerWeb.PageController do
  use PaintSchemerWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
