defmodule Domain.Users do
  @moduledoc false

  alias Domain.{User, Repo}

  def all do
    Repo.all(User)
  end

  # Possibly this one should be more general
  def find_by_params(params) do
    Repo.get_by!(User, params)
  end

  def create_user!(params) do
    changeset = User.create_changeset(%User{}, params)

    case Repo.insert(changeset) do
      {:ok, struct}       -> struct
      {:error, changeset} -> changeset
    end
  end

  def edit_user(id, params) do
    user = Repo.get!(User, id)
    changeset = User.update_changeset(user, params)

    case Repo.update(changeset) do
     {:ok, struct}       -> struct
     {:error, changeset} -> changeset
    end
  end

  def delete_user(id) do
    user = Repo.get!(User, id)

    Repo.delete!(user)
  end
end
