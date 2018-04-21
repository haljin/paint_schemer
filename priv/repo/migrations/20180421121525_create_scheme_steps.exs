defmodule PaintSchemer.Repo.Migrations.CreateSchemeSteps do
  use Ecto.Migration

  def change do
    create table(:scheme_steps) do
      add :ordering, :integer
      add :section_id, references(:scheme_sections, on_delete: :nothing)
      add :technique_id, references(:paint_techniques, on_delete: :nothing)

      timestamps()
    end

    create index(:scheme_steps, [:section_id])
    create index(:scheme_steps, [:technique_id])
  end
end
