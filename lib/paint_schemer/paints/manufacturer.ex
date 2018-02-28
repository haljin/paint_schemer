defmodule PaintSchemer.Paints.Manufacturer do
  use Ecto.Schema
  import Ecto.Changeset
  alias PaintSchemer.Paints.Manufacturer


  schema "paint_manufacturers" do
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(%Manufacturer{} = manufacturer, attrs) do
    manufacturer
    |> cast(attrs, [:name])
    |> validate_required([:name])
    |> unique_constraint(:name)
  end
end
