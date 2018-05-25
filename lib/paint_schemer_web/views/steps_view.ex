defmodule PaintSchemerWeb.StepView do
  use PaintSchemerWeb, :view
  alias PaintSchemerWeb.StepView

  def render("index.json", %{scheme_step: scheme_step}) do
    %{data: render_many(scheme_step, StepView, "step.json")}
  end

  def render("show.json", %{step: step}) do
    %{data: render_one(step, StepView, "step.json")}
  end

  def render("step.json", %{step: step}) do
    %{id: step.id, ordering: step.ordering}
  end
end
