defmodule PaintSchemer.Repo.Migrations.CreatePaintTypes do
  use Ecto.Migration

  def change do
    create table(:paint_types) do
      add :name, :string

      timestamps()
    end

  end
end
