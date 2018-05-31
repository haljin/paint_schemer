defmodule PaintSchemerWeb.SchemeController do
  use PaintSchemerWeb, :controller
  alias PaintSchemer.Schemes
  alias PaintSchemer.Schemes.Scheme

  action_fallback(PaintSchemerWeb.FallbackController)

  def index(conn, %{"page" => page_number} \\ %{"page" => "1"}) do
    schemes = Schemes.list_schemes_page(3, String.to_integer(page_number))
    render(conn, "index.json", schemes: schemes)
  end

  def create(conn, %{"scheme" => %{}} = data) do
    mapped_data = map_json(data)

    with {:ok, %Scheme{} = scheme} <- Schemes.create_scheme(mapped_data["scheme"]) do
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

  def update(conn, %{"id" => id, "scheme" => scheme_params} = data) do
    scheme = Schemes.get_scheme!(id)
    %{"scheme" => scheme_params} = mapped_data = map_json(data)

    with {:ok, %Scheme{} = scheme} <- Schemes.update_scheme(scheme, scheme_params) do
      render(conn, "updated.json", scheme: scheme)
    end
  end

  def delete(conn, %{"id" => id}) do
    scheme = Schemes.get_scheme!(id)

    with {:ok, %Scheme{}} <- Schemes.delete_scheme(scheme) do
      send_resp(conn, :no_content, "")
    end
  end

  defp map_json(%{"scheme" => %{"sections" => sections} = scheme_params}) do
    %{"scheme" => %{scheme_params | "sections" => Enum.map(sections, &map_section_fields/1)}}
  end

  defp map_section_fields(%{"steps" => steps} = section) do
    new_steps =
      steps
      |> Enum.with_index()
      |> Enum.map(&map_step_fields/1)

    %{section | "steps" => new_steps}
  end

  defp map_step_fields({%{"technique" => %{"id" => id}, "paints" => paints} = step, index}) do
    Map.merge(step, %{"paint_technique_id" => id, "ordering" => index, "paints" => Enum.map(paints, &map_paints/1)})
  end

  defp map_paints(%{"paint" => %{"id" => id}, "ratio" => _ratio} = paint_info) do
    Map.put(paint_info, "paint_id", id)
  end

  defp map_paints(paint_info) do
    map_paints(Map.put(paint_info, "ratio", 1))
  end
end
