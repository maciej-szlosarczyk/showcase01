defmodule Domain.Repo.Migrations.AddOrderTable do
  @moduledoc false
  use Ecto.Migration

  def change do
    create table(:orders) do
      add :base_currency, :string, null: false
      add :target_currency, :string, null: false
      add :amount, :decimal, null: false
      add :start_date, :date, null: false
      add :end_date, :date, null: false
      add :user_id, references(:users, on_delete: :delete_all)

      timestamps()
    end

    create index(:orders, [:user_id])
  end
end
