defmodule PaintSchemerWeb.PaintTechniqueView do
  use PaintSchemerWeb, :view
  alias PaintSchemerWeb.PaintTechniqueView

  def render("index.json", %{paint_technique: paint_technique}) do
    %{data: render_many(paint_technique, PaintTechniqueView, "paint_technique.json")}
  end

  def render("show.json", %{paint_technique: paint_technique}) do
    %{data: render_one(paint_technique, PaintTechniqueView, "paint_technique.json")}
  end

  def render("paint_technique.json", %{paint_technique: paint_technique}) do
    %{id: paint_technique.id, name: paint_technique.name}
  end
end
