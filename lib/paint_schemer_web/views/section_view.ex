defmodule PaintSchemerWeb.SectionView do
  use PaintSchemerWeb, :view
  alias PaintSchemerWeb.SectionView

  def render("index.json", %{scheme_section: scheme_section}) do
    %{data: render_many(scheme_section, SectionsView, "section.json")}
  end

  def render("show.json", %{section: section}) do
    %{data: render_one(section, SectionView, "section.json")}
  end

  def render("section.json", %{section: section}) do
    %{id: section.id}
  end
end
