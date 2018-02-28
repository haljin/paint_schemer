defmodule PaintSchemer.Repo.Migrations.CreatePaints do
  use Ecto.Migration

  def change do
    create table(:paints) do
      add :name, :string
      add :color, :binary
      add :manufacturer_id, references(:paint_manufacturers, on_delete: :nothing)
      add :type_id, references(:paint_types, on_delete: :nothing)

      timestamps()
    end

    create index(:paints, [:manufacturer_id])
    create index(:paints, [:type_id])
  end
end
