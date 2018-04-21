defmodule PaintSchemer.Schemes.Sections do
  use Ecto.Schema
  import Ecto.Changeset
  alias PaintSchemer.Schemes.Sections


  schema "scheme_sections" do
    field :ordering, :integer
    field :scheme_id, :id

    timestamps()
  end

  @doc false
  def changeset(%Sections{} = sections, attrs) do
    sections
    |> cast(attrs, [:ordering])
    |> validate_required([:ordering])
  end
end
