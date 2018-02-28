defmodule PaintSchemer.Paints.Type do
  use Ecto.Schema
  import Ecto.Changeset
  alias PaintSchemer.Paints.Type


  schema "paint_types" do
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(%Type{} = type, attrs) do
    type
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
