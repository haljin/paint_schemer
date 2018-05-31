defmodule PaintSchemerWeb.SchemeView do
  use PaintSchemerWeb, :view
  alias PaintSchemerWeb.{SchemeView, PaintView}
  alias PaintSchemer.{Schemes, Paints}

  def render("index.json", %{schemes: schemes}) do
    %{data: render_many(schemes, SchemeView, "scheme.json")}
  end

  def render("show.json", %{scheme: scheme}) do
    %{data: render_one(scheme, SchemeView, "scheme.json")}
  end

  def render("updated.json", %{scheme: scheme}) do
    %{updated: true}
  end

  def render("scheme.json", %{scheme: scheme}) do
    sections =
      case scheme.sections do
        sec when is_list(sec) -> Enum.map(scheme.sections, &render_section/1)
        _ -> nil
      end

    %{
      id: scheme.id,
      title: scheme.title,
      description: scheme.description,
      image_url: scheme.image_url,
      sections: sections
    }
  end

  defp render_section(%Schemes.Section{id: id, name: name, steps: steps}) do
    %{
      id: id,
      name: name,
      steps:
        steps
        |> Enum.sort_by(& &1.ordering)
        |> Enum.map(&render_steps/1)
    }
  end

  defp render_steps(%Schemes.Step{id: id, paints: paints, paint_technique: %Paints.PaintTechnique{id: tech_id, name: technique_name}}) do
    %{
      id: id,
      paints: Enum.map(paints, &render_paint_mix/1),
      technique: %{
        id: tech_id,
        name: technique_name
      }
    }
  end

  defp render_paint_mix(%Schemes.PaintMix{id: id, ratio: ratio, paint: paint}) do
    %{
      id: id,
      ratio: ratio,
      paint: PaintView.render("paint.json", %{paint: paint})
    }
  end
end
