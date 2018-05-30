defmodule PaintSchemer.Schemes.Step do
  @moduledoc false
  use Ecto.Schema
  import Ecto.Changeset
  alias PaintSchemer.Paints.PaintTechnique
  alias PaintSchemer.Schemes.{Section, Step, PaintMix}

  schema "scheme_steps" do
    field :ordering, :integer
    belongs_to :paint_technique, PaintTechnique
    belongs_to :section, Section
    has_many :paints, PaintMix, on_replace: :delete

    timestamps()
  end

  @doc false
  def changeset(%Step{} = step, attrs) do
    step
    |> cast(attrs, [:ordering, :paint_technique_id])
    |> validate_required([:ordering, :paint_technique_id])
    |> cast_assoc(:paints, with: &PaintMix.changeset/2)
  end
end
