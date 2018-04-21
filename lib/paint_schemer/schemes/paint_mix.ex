defmodule PaintSchemer.Schemes.PaintMix do
  use Ecto.Schema
  import Ecto.Changeset
  alias PaintSchemer.Schemes.PaintMix


  schema "scheme_mixes" do
    field :ratio, :integer
    field :step_id, :id
    field :paint_id, :id

    timestamps()
  end

  @doc false
  def changeset(%PaintMix{} = paint_mix, attrs) do
    paint_mix
    |> cast(attrs, [:ratio])
    |> validate_required([:ratio])
  end
end
