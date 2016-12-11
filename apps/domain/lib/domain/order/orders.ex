defmodule Domain.Orders do
  @moduledoc false

  alias Domain.{Order, Repo}
  import Ecto.Query, only: [from: 2]

  def all do
    Repo.all(Order)
  end

  def build_order do
    Order.create_changeset(%Order{})
  end

  def update_order do
    Order.update_changeset(%Order{})
  end

  def find_by_params(params) do
    Repo.get_by!(Order, params)
  end

  def filter_by_user(user_id) do
    orders =
      from o in Order,
      where: o.user_id == ^user_id

    Repo.all(orders)
  end

  def create_order!(params) do
    changeset = Order.create_changeset(%Order{}, params)

    case Repo.insert(changeset) do
      {:ok, struct}       -> {:ok, struct}
      {:error, changeset} -> {:error, changeset}
    end
  end
end
