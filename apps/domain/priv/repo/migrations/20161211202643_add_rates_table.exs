defmodule Domain.Repo.Migrations.AddRatesTable do
  use Ecto.Migration

  def change do
    create table(:rates) do
      add :data, :map, null: false
      add :date, :date, null: false

      timestamps()
    end

    create index(:rates, [:date])
  end
end
