defmodule PaintSchemerWeb.PaintMixView do
  use PaintSchemerWeb, :view
  alias PaintSchemerWeb.PaintMixView

  def render("index.json", %{scheme_mixes: scheme_mixes}) do
    %{data: render_many(scheme_mixes, PaintMixView, "paint_mix.json")}
  end

  def render("show.json", %{paint_mix: paint_mix}) do
    %{data: render_one(paint_mix, PaintMixView, "paint_mix.json")}
  end

  def render("paint_mix.json", %{paint_mix: paint_mix}) do
    %{id: paint_mix.id, ratio: paint_mix.ratio}
  end
end
