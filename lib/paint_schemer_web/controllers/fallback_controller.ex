defmodule PaintSchemerWeb.FallbackController do
  @moduledoc """
  Translates controller action results into valid `Plug.Conn` responses.

  See `Phoenix.Controller.action_fallback/1` for more details.
  """
  use PaintSchemerWeb, :controller

  def call(conn, {:error, %Ecto.Changeset{} = changeset}) do
    conn
    |> put_status(:unprocessable_entity)
    |> render(PaintSchemerWeb.ChangesetView, "error.json", changeset: changeset)
  end

  def call(conn, {:error, :bad_input}) do
    conn
    |> put_status(:unprocessable_entity)
    |> render(PaintSchemerWeb.ErrorView, :"422")
  end

  def call(conn, {:error, :not_found}) do
    conn
    |> put_status(:not_found)
    |> render(PaintSchemerWeb.ErrorView, :"404")
  end
end
