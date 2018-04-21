defmodule PaintSchemer.Paints.PaintTechnique do
  use Ecto.Schema
  import Ecto.Changeset
  alias PaintSchemer.Paints.PaintTechnique


  schema "paint_techniques" do
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(%PaintTechnique{} = paint_technique, attrs) do
    paint_technique
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
