defmodule PaintSchemer.Paints.PaintType do
  @moduledoc false
  use Ecto.Schema
  import Ecto.Changeset
  alias PaintSchemer.Paints.PaintType

  schema "paint_types" do
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(%PaintType{} = paint_type, attrs) do
    paint_type
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
