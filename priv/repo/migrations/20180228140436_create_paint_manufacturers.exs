defmodule PaintSchemer.Repo.Migrations.CreatePaintManufacturers do
  use Ecto.Migration

  def change do
    create table(:paint_manufacturers) do
      add :name, :string

      timestamps()
    end

    create unique_index(:paint_manufacturers, [:name])
  end
end
