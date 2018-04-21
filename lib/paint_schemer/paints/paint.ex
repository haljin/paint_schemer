defmodule PaintSchemer.Paints.Paint do
  use Ecto.Schema
  import Ecto.Changeset
  alias PaintSchemer.Paints.Paint


  schema "paints" do
    field :color, :binary
    field :name, :string
    belongs_to :manufacturer, PaintSchemer.Paints.Manufacturer
    belongs_to :type, PaintSchemer.Paints.PaintType

    timestamps()
  end

  @doc false
  def changeset(%Paint{} = paint, attrs) do
    paint
    |> cast(attrs, [:name, :color, :type_id, :manufacturer_id])
    |> validate_required([:name, :color, :type_id, :manufacturer_id], trim: false)
  end
end
