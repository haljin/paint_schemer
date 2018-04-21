defmodule PaintSchemer.Repo.Migrations.CreatePaintTechnique do
  use Ecto.Migration

  def change do
    create table(:paint_techniques) do
      add :name, :string

      timestamps()
    end

  end
end
