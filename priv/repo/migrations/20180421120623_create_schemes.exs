defmodule PaintSchemer.Repo.Migrations.CreateSchemes do
  use Ecto.Migration

  def change do
    create table(:schemes) do
      add :title, :string
      add :description, :string
      add :image_url, :string

      timestamps()
    end

  end
end
