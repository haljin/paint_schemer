defmodule PaintSchemer.Schemes.Scheme do
  use Ecto.Schema
  import Ecto.Changeset
  alias PaintSchemer.Schemes.Scheme


  schema "schemes" do
    field :description, :string
    field :image_url, :string
    field :title, :string
    has_many :sections, PaintSchemer.Schemes.Section

    timestamps()
  end

  @doc false
  def changeset(%Scheme{} = scheme, attrs) do
    a =
    scheme
    |> cast(attrs, [:title, :description, :image_url])
    |> validate_required([:title])
    |> cast_assoc(:sections, with: &PaintSchemer.Schemes.Section.changeset/2)
    IO.inspect a
    a
  end
end
