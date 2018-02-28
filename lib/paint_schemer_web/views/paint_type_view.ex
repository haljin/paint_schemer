defmodule PaintSchemerWeb.PaintTypeView do
  use PaintSchemerWeb, :view
  alias PaintSchemerWeb.PaintTypeView

  def render("index.json", %{paint_types: paint_types}) do
    %{data: render_many(paint_types, PaintTypeView, "paint_type.json")}
  end

  def render("show.json", %{paint_type: paint_type}) do
    %{data: render_one(paint_type, PaintTypeView, "paint_type.json")}
  end

  def render("paint_type.json", %{paint_type: paint_type}) do
    %{id: paint_type.id,
      name: paint_type.name}
  end
end
