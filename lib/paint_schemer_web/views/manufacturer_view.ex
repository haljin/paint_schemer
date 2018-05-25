defmodule PaintSchemerWeb.ManufacturerView do
  use PaintSchemerWeb, :view
  alias PaintSchemerWeb.ManufacturerView

  def render("index.json", %{paint_manufacturers: paint_manufacturers}) do
    %{data: render_many(paint_manufacturers, ManufacturerView, "manufacturer.json")}
  end

  def render("show.json", %{manufacturer: manufacturer}) do
    %{data: render_one(manufacturer, ManufacturerView, "manufacturer.json")}
  end

  def render("manufacturer.json", %{manufacturer: manufacturer}) do
    %{id: manufacturer.id, name: manufacturer.name}
  end
end
