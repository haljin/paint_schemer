defmodule PaintSchemerWeb.SectionsView do
  use PaintSchemerWeb, :view
  alias PaintSchemerWeb.SectionsView

  def render("index.json", %{scheme_sections: scheme_sections}) do
    %{data: render_many(scheme_sections, SectionsView, "sections.json")}
  end

  def render("show.json", %{sections: sections}) do
    %{data: render_one(sections, SectionsView, "sections.json")}
  end

  def render("sections.json", %{sections: sections}) do
    %{id: sections.id,
      ordering: sections.ordering}
  end
end
