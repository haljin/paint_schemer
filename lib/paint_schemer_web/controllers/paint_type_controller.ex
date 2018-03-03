defmodule PaintSchemerWeb.PaintTypeController do
  use PaintSchemerWeb, :controller

  alias PaintSchemer.Paints
  alias PaintSchemer.Paints.PaintType

  action_fallback PaintSchemerWeb.FallbackController

  def index(conn, _params) do
    paint_types = Paints.list_paint_types()
    render(conn, "index.json", paint_types: paint_types)
  end

  def create(conn, %{"data" => paint_type_params}) do
    with {:ok, %PaintType{} = paint_type} <- Paints.create_paint_type(paint_type_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", paint_type_path(conn, :show, paint_type))
      |> render("show.json", paint_type: paint_type)
    end
  end

  def show(conn, %{"id" => id}) do
    paint_type = Paints.get_paint_type!(id)
    render(conn, "show.json", paint_type: paint_type)
  end

  def update(conn, %{"id" => id, "data" => paint_type_params}) do
    paint_type = Paints.get_paint_type!(id)

    with {:ok, %PaintType{} = paint_type} <- Paints.update_paint_type(paint_type, paint_type_params) do
      render(conn, "show.json", paint_type: paint_type)
    end
  end

  def delete(conn, %{"id" => id}) do
    paint_type = Paints.get_paint_type!(id)
    with {:ok, %PaintType{}} <- Paints.delete_paint_type(paint_type) do
      send_resp(conn, :no_content, "")
    end
  end
end
