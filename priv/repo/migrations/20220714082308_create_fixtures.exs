defmodule LiveOperations.Repo.Migrations.CreateFixtures do
  use Ecto.Migration

  def change do
    create table(:fixtures) do
      add :home_score, :integer
      add :away_score, :integer
      add :kickoff, :naive_datetime
      add :active, :boolean, default: false, null: false
      add :result, :boolean, default: false, null: false
      add :home_id, references(:football, on_delete: :nothing)
      add :away_id, references(:football, on_delete: :nothing)

      timestamps()
    end

    create index(:fixtures, [:away_id])
    create index(:fixtures, [:home_id])
  end
end
