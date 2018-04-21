defmodule PaintSchemerWeb.StepsController do
  use PaintSchemerWeb, :controller

  alias PaintSchemer.Schemes
  alias PaintSchemer.Schemes.Steps

  action_fallback PaintSchemerWeb.FallbackController

  def index(conn, _params) do
    scheme_steps = Schemes.list_scheme_steps()
    render(conn, "index.json", scheme_steps: scheme_steps)
  end

  def create(conn, %{"steps" => steps_params}) do
    with {:ok, %Steps{} = steps} <- Schemes.create_steps(steps_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", steps_path(conn, :show, steps))
      |> render("show.json", steps: steps)
    end
  end

  def show(conn, %{"id" => id}) do
    steps = Schemes.get_steps!(id)
    render(conn, "show.json", steps: steps)
  end

  def update(conn, %{"id" => id, "steps" => steps_params}) do
    steps = Schemes.get_steps!(id)

    with {:ok, %Steps{} = steps} <- Schemes.update_steps(steps, steps_params) do
      render(conn, "show.json", steps: steps)
    end
  end

  def delete(conn, %{"id" => id}) do
    steps = Schemes.get_steps!(id)
    with {:ok, %Steps{}} <- Schemes.delete_steps(steps) do
      send_resp(conn, :no_content, "")
    end
  end
end
