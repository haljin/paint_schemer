defmodule PaintSchemerWeb.SchemeView do
  use PaintSchemerWeb, :view
  alias PaintSchemerWeb.SchemeView
  alias PaintSchemer.Schemes
  alias PaintSchemer.Paints

  def render("index.json", %{schemes: schemes}) do
    %{data: render_many(schemes, SchemeView, "scheme.json")}
  end

  def render("show.json", %{scheme: scheme}) do
    %{data: render_one(scheme, SchemeView, "scheme.json")}
  end

  def render("scheme.json", %{scheme: scheme}) do
    %{id: scheme.id,
      title: scheme.title,
      description: scheme.description,
      image_url: scheme.image_url,
      sections: Enum.map(scheme.sections, &render_section/1)
    }
  end

  defp render_section(%Schemes.Section{id: id, name: name, steps: steps}) do
    %{
      id: id,
      name: name,
      steps: Enum.map(steps, &render_steps/1)
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
    Map.merge(
    %{
      id: id,
      ratio: ratio
    },
    PaintSchemerWeb.PaintView.render("paint.json", %{paint: paint})
    )
  end
end
