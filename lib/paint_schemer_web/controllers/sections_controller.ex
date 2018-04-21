defmodule PaintSchemerWeb.SectionsController do
  use PaintSchemerWeb, :controller

  alias PaintSchemer.Schemes
  alias PaintSchemer.Schemes.Sections

  action_fallback PaintSchemerWeb.FallbackController

  def index(conn, _params) do
    scheme_sections = Schemes.list_scheme_sections()
    render(conn, "index.json", scheme_sections: scheme_sections)
  end

  def create(conn, %{"sections" => sections_params}) do
    with {:ok, %Sections{} = sections} <- Schemes.create_sections(sections_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", sections_path(conn, :show, sections))
      |> render("show.json", sections: sections)
    end
  end

  def show(conn, %{"id" => id}) do
    sections = Schemes.get_sections!(id)
    render(conn, "show.json", sections: sections)
  end

  def update(conn, %{"id" => id, "sections" => sections_params}) do
    sections = Schemes.get_sections!(id)

    with {:ok, %Sections{} = sections} <- Schemes.update_sections(sections, sections_params) do
      render(conn, "show.json", sections: sections)
    end
  end

  def delete(conn, %{"id" => id}) do
    sections = Schemes.get_sections!(id)
    with {:ok, %Sections{}} <- Schemes.delete_sections(sections) do
      send_resp(conn, :no_content, "")
    end
  end
end
