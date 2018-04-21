defmodule PaintSchemer.Repo.Migrations.CreateSchemeSections do
  use Ecto.Migration

  def change do
    create table(:scheme_sections) do
      add :scheme_id, references(:schemes, on_delete: :delete_all)

      timestamps()
    end

    create index(:scheme_sections, [:scheme_id])
  end
end
