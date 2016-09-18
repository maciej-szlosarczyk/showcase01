defmodule Domain.User do
  @moduledoc false

  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :first_name, :string, null: false
    field :last_name, :string, null: false
    field :email, :string, null: false
    field :password_hash, :string, null: false
    field :password, :string, virtual: true

    timestamps()
  end

  def create_changeset(user, params \\ %{}) do
    user
    |> cast(params, [:first_name, :last_name, :email, :password])
    |> validate_required([:first_name, :last_name, :email, :password])
    |> validate_length(:password, min: 8)
    |> validate_confirmation(:password, message: "Passwords do not match")
    |> validate_format(:email, ~r/@/)
    |> hash_password
    |> unique_constraint(:email)
  end

  def update_changeset(user, params \\ %{}) do
    user
    |> cast(params, [:first_name, :last_name, :email, :password])
    |> validate_length(:password, min: 8)
    |> validate_confirmation(:password, message: "Passwords do not match")
    |> validate_format(:email, ~r/@/)
    |> hash_password
    |> unique_constraint(:email)
  end

  defp hash_password(changeset) do
    password = get_change(changeset, :password)

    case password do
      x when is_bitstring(x) ->
        changeset
        |> put_change(:password_hash, Comeonin.Bcrypt.hashpwsalt(password))
        |> put_change(:password, nil)
      _                      ->
        changeset
    end
  end
end
