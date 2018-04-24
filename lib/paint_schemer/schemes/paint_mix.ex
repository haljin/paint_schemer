defmodule PaintSchemer.Schemes.PaintMix do
  use Ecto.Schema
  import Ecto.Changeset
  alias PaintSchemer.Schemes.PaintMix


  schema "scheme_mixes" do
    field :ratio, :integer
    belongs_to :step, PaintSchemer.Schemes.Step
    belongs_to :paint, PaintSchemer.Paints.PaintTechnique

    timestamps()
  end

  @doc false
  def changeset(%PaintMix{} = paint_mix, attrs) do
    paint_mix
    |> cast(attrs, [:ratio, :paint_id])
    |> validate_required([:ratio, :paint_id])
  end
end
