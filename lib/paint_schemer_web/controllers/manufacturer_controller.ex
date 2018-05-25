defmodule PaintSchemerWeb.ManufacturerController do
  use PaintSchemerWeb, :controller

  alias PaintSchemer.Paints
  alias PaintSchemer.Paints.Manufacturer

  action_fallback(PaintSchemerWeb.FallbackController)

  def index(conn, _params) do
    paint_manufacturers = Paints.list_paint_manufacturers()
    render(conn, "index.json", paint_manufacturers: paint_manufacturers)
  end

  def create(conn, %{"data" => manufacturer_params}) do
    with {:ok, %Manufacturer{} = manufacturer} <- Paints.create_manufacturer(manufacturer_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", manufacturer_path(conn, :show, manufacturer))
      |> render("show.json", manufacturer: manufacturer)
    end
  end

  def show(conn, %{"id" => id}) do
    manufacturer = Paints.get_manufacturer!(id)
    render(conn, "show.json", manufacturer: manufacturer)
  end

  def delete(conn, %{"id" => id}) do
    manufacturer = Paints.get_manufacturer!(id)

    with {:ok, %Manufacturer{}} <- Paints.delete_manufacturer(manufacturer) do
      send_resp(conn, :no_content, "")
    end
  end
end
