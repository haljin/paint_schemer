defmodule PaintSchemer.Schemes.Steps do
  use Ecto.Schema
  import Ecto.Changeset
  alias PaintSchemer.Schemes.Steps


  schema "scheme_steps" do
    field :ordering, :integer
    field :section_id, :id
    field :technique_id, :id

    timestamps()
  end

  @doc false
  def changeset(%Steps{} = steps, attrs) do
    steps
    |> cast(attrs, [:ordering])
    |> validate_required([:ordering])
  end
end
