defmodule PaintSchemerWeb.PageControllerTest do
  use PaintSchemerWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, "/")
    assert html_response(conn, 200)
  end
end
