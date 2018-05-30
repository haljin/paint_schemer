defmodule PaintSchemer.Repo.Migrations.CreateSchemeMixes do
  use Ecto.Migration

  def change do
    create table(:scheme_mixes) do
      add(:ratio, :integer)
      add(:step_id, references(:scheme_steps, on_delete: :delete_all))
      add(:paint_id, references(:paints, on_delete: :nothing))

      timestamps()
    end

    create(index(:scheme_mixes, [:step_id]))
    create(index(:scheme_mixes, [:paint_id]))
  end
end
