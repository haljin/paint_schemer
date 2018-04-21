defmodule PaintSchemerWeb.StepController do
  use PaintSchemerWeb, :controller

  alias PaintSchemer.Schemes
  alias PaintSchemer.Schemes.Step

  action_fallback PaintSchemerWeb.FallbackController

  def index(conn, _params) do
    scheme_step = Schemes.list_scheme_step()
    render(conn, "index.json", scheme_step: scheme_step)
  end

  def create(conn, %{"step" => step_params}) do
    with {:ok, %Step{} = step} <- Schemes.create_step(step_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", step_path(conn, :show, step))
      |> render("show.json", step: step)
    end
  end

  def show(conn, %{"id" => id}) do
    step = Schemes.get_step!(id)
    render(conn, "show.json", step: step)
  end

  def update(conn, %{"id" => id, "step" => step_params}) do
    step = Schemes.get_step!(id)

    with {:ok, %Step{} = step} <- Schemes.update_step(step, step_params) do
      render(conn, "show.json", step: step)
    end
  end

  def delete(conn, %{"id" => id}) do
    step = Schemes.get_step!(id)
    with {:ok, %Step{}} <- Schemes.delete_step(step) do
      send_resp(conn, :no_content, "")
    end
  end
end
