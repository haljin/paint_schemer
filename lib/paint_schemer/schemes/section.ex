defmodule PaintSchemer.Schemes.Section do
  use Ecto.Schema
  import Ecto.Changeset
  alias PaintSchemer.Schemes.Section


  schema "scheme_sections" do
    field :name, :string
    belongs_to :scheme, PaintSchemer.Schemes.Scheme
    has_many :steps, PaintSchemer.Schemes.Step

    timestamps()
  end

  @doc false
  def changeset(%Section{} = section, attrs) do
    section
    |> cast(attrs, [:scheme_id])
    |> validate_required([:scheme_id])
  end
end
