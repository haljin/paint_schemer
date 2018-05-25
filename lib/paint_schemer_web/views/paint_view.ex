defmodule PaintSchemerWeb.PaintView do
  use PaintSchemerWeb, :view
  alias PaintSchemerWeb.PaintView
  require Logger

  def render("index.json", %{paints: paints}) do
    %{data: render_many(paints, PaintView, "paint.json")}
  end

  def render("show.json", %{paint: paint}) do
    %{data: render_one(paint, PaintView, "paint.json")}
  end

  def render("paint.json", %{paint: paint}) do
    %{
      id: paint.id,
      name: paint.name,
      manufacturer: association_field(paint.manufacturer),
      type: association_field(paint.type),
      color: "#" <> Base.encode16(paint.color)
    }
  end

  defp association_field(nil), do: nil

  defp association_field(relation) do
    case Ecto.assoc_loaded?(relation) do
      true -> relation.name
      false -> nil
    end
  end
end
