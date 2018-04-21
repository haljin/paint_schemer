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

# mix phx.gen.json Paints Paint paints name:string manufacturer_id:references:paint_manufacturers color:binary type_id:references:paint_types
