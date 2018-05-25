defmodule PaintSchemer.Schemes.Section do
  @moduledoc false
  use Ecto.Schema
  import Ecto.Changeset
  alias PaintSchemer.Schemes.{Step, Section}

  schema "scheme_sections" do
    field :name, :string
    belongs_to :scheme, Scheme
    has_many(:steps, Step)

    timestamps()
  end

  @doc false
  def changeset(%Section{} = section, attrs) do
    section
    |> cast(attrs, [:name])
    |> validate_required([:name])
    |> cast_assoc(:steps, with: &Step.changeset/2)
  end
end
