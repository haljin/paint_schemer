defmodule PaintSchemer.Paints.Paint do
  use Ecto.Schema
  import Ecto.Changeset
  alias PaintSchemer.Paints.Paint


  schema "paints" do
    field :color, :binary
    field :name, :string
    field :manufacturer_id, :id
    field :type_id, :id

    timestamps()
  end

  @doc false
  def changeset(%Paint{} = paint, attrs) do
    paint
    |> cast(attrs, [:name, :color])
    |> validate_required([:name, :color])
  end
end
