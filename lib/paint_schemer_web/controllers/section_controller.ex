defmodule PaintSchemerWeb.SectionController do
  use PaintSchemerWeb, :controller

  alias PaintSchemer.Schemes
  alias PaintSchemer.Schemes.Section

  action_fallback PaintSchemerWeb.FallbackController

  def index(conn, _params) do
    scheme_section = Schemes.list_scheme_section()
    render(conn, "index.json", scheme_section: scheme_section)
  end

  def create(conn, %{"section" => section_params}) do
    with {:ok, %Section{} = section} <- Schemes.create_section(section_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", section_path(conn, :show, section))
      |> render("show.json", section: section)
    end
  end

  def show(conn, %{"id" => id}) do
    section = Schemes.get_section!(id)
    render(conn, "show.json", section: section)
  end

  def update(conn, %{"id" => id, "section" => section_params}) do
    section = Schemes.get_section!(id)

    with {:ok, %Section{} = section} <- Schemes.update_section(section, section_params) do
      render(conn, "show.json", section: section)
    end
  end

  def delete(conn, %{"id" => id}) do
    section = Schemes.get_section!(id)
    with {:ok, %Section{}} <- Schemes.delete_section(section) do
      send_resp(conn, :no_content, "")
    end
  end
end
