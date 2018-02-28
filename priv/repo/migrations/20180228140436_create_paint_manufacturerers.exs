defmodule PaintSchemer.Repo.Migrations.CreatePaintManufacturerers do
  use Ecto.Migration

  def change do
    create table(:paint_manufacturerers) do
      add :name, :string

      timestamps()
    end

    create unique_index(:paint_manufacturerers, [:name])
  end
end
