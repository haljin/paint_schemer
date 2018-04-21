defmodule PaintSchemer.Schemes.Scheme do
  use Ecto.Schema
  import Ecto.Changeset
  alias PaintSchemer.Schemes.Scheme


  schema "schemes" do
    field :description, :string
    field :image_url, :string
    field :title, :string

    timestamps()
  end

  @doc false
  def changeset(%Scheme{} = scheme, attrs) do
    scheme
    |> cast(attrs, [:title, :description, :image_url])
    |> validate_required([:title, :description, :image_url])
  end
end
