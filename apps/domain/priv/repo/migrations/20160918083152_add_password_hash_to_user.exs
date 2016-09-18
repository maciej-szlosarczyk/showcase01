defmodule Domain.Repo.Migrations.AddPasswordHashToUser do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :password_hash, :string
      remove :password
    end
  end
end
