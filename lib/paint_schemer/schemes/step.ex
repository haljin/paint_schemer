defmodule PaintSchemer.Schemes.Step do
  use Ecto.Schema
  import Ecto.Changeset
  alias PaintSchemer.Schemes.Step


  schema "scheme_steps" do
    field :ordering, :integer
    belongs_to :paint_technique, PaintSchemer.Paints.PaintTechnique
    belongs_to :section, PaintSchemer.Schemes.Section
    has_many :paint_mixes, PaintSchemer.Schemes.PaintMix


    timestamps()
  end

  @doc false
  def changeset(%Step{} = step, attrs) do
    step
    |> cast(attrs, [:ordering, :section_id, :paint_technique_id])
    |> validate_required([:ordering, :section_id, :paint_technique_id])
  end
end
