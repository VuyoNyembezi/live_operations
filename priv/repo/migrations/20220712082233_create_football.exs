defmodule LiveOperations.Repo.Migrations.CreateFootball do
  use Ecto.Migration

  def change do
    create table(:football) do
      add :badge, :string
      add :name, :string
      add :win, :integer
      add :draw, :integer
      add :loss, :integer
      add :points, :integer

      timestamps()
    end

    create unique_index(:football, [:name])
    create unique_index(:football, [:badge])
  end
end
