defmodule PaintSchemerWeb.SchemeController do
  use PaintSchemerWeb, :controller

  alias PaintSchemer.Schemes
  alias PaintSchemer.Schemes.Scheme

  action_fallback PaintSchemerWeb.FallbackController

  def index(conn, _params) do
    schemes = Schemes.list_schemes()
    render(conn, "index.json", schemes: schemes)
  end

  def create(conn, %{"scheme" => scheme_params}) do
    with {:ok, %Scheme{} = scheme} <- Schemes.create_scheme(scheme_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", scheme_path(conn, :show, scheme))
      |> render("show.json", scheme: scheme)
    end
  end

  def show(conn, %{"id" => id}) do
    scheme = Schemes.get_scheme!(id)
    render(conn, "show.json", scheme: scheme)
  end

  def update(conn, %{"id" => id, "scheme" => scheme_params}) do
    scheme = Schemes.get_scheme!(id)

    with {:ok, %Scheme{} = scheme} <- Schemes.update_scheme(scheme, scheme_params) do
      render(conn, "show.json", scheme: scheme)
    end
  end

  def delete(conn, %{"id" => id}) do
    scheme = Schemes.get_scheme!(id)
    with {:ok, %Scheme{}} <- Schemes.delete_scheme(scheme) do
      send_resp(conn, :no_content, "")
    end
  end
end
