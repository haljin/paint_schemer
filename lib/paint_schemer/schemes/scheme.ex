defmodule PaintSchemer.Schemes.Scheme do
  @moduledoc false
  use Ecto.Schema
  import Ecto.Changeset
  alias PaintSchemer.Repo
  alias PaintSchemer.Schemes.{Scheme, Section}

  schema "schemes" do
    field :description, :string
    field :image_url, :string
    field :title, :string
    has_many :sections, Section, on_replace: :delete

    timestamps()
  end

  @doc false
  def changeset(%Scheme{} = scheme, attrs) do
    scheme
    |> Repo.preload(:sections)
    |> cast(attrs, [:title, :description, :image_url])
    |> validate_required([:title])
    |> cast_assoc(:sections, with: &Section.changeset/2)
  end
end
