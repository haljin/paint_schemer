defmodule PaintSchemer.Schemes.Step do
  use Ecto.Schema
  import Ecto.Changeset
  alias PaintSchemer.Schemes.Step


  schema "scheme_steps" do
    field :ordering, :integer
    belongs_to :paint_technique, PaintSchemer.Paints.PaintTechnique
    belongs_to :section, PaintSchemer.Schemes.Section
    has_many :paints, PaintSchemer.Schemes.PaintMix


    timestamps()
  end

  @doc false
  def changeset(%Step{} = step, attrs) do
    step
    |> cast(attrs, [:ordering, :paint_technique_id])
    |> validate_required([:ordering, :paint_technique_id])
    |> cast_assoc(:paints, with: &PaintSchemer.Schemes.PaintMix.changeset/2)
  end
end
