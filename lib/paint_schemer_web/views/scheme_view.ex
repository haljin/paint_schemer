defmodule PaintSchemerWeb.SchemeView do
  use PaintSchemerWeb, :view
  alias PaintSchemerWeb.SchemeView

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
      image_url: scheme.image_url}
  end
end
