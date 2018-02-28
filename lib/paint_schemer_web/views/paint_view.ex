defmodule PaintSchemerWeb.PaintView do
  use PaintSchemerWeb, :view
  alias PaintSchemerWeb.PaintView

  def render("index.json", %{paints: paints}) do
    %{data: render_many(paints, PaintView, "paint.json")}
  end

  def render("show.json", %{paint: paint}) do
    %{data: render_one(paint, PaintView, "paint.json")}
  end

  def render("paint.json", %{paint: paint}) do
    %{id: paint.id,
      name: paint.name,
      color: paint.color}
  end
end
