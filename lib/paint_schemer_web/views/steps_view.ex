defmodule PaintSchemerWeb.StepsView do
  use PaintSchemerWeb, :view
  alias PaintSchemerWeb.StepsView

  def render("index.json", %{scheme_steps: scheme_steps}) do
    %{data: render_many(scheme_steps, StepsView, "steps.json")}
  end

  def render("show.json", %{steps: steps}) do
    %{data: render_one(steps, StepsView, "steps.json")}
  end

  def render("steps.json", %{steps: steps}) do
    %{id: steps.id,
      ordering: steps.ordering}
  end
end
