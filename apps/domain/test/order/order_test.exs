defmodule OrderTest do
  @moduledoc false

  alias Domain.Repo
  alias Ecto.Adapters.SQL.Sandbox
  alias Ecto.Date

  use ExUnit.Case, async: true

  setup do
    :ok = Sandbox.checkout(Repo)
  end

  alias Domain.Order

  {new_date, _} = :calendar.now_to_datetime(:os.timestamp)

  @valid_attrs %{base_currency: "EUR", target_currency: "GBP", amount: 1200,
                 end_date: Date.cast!(new_date), user_id: 1}
  @invalid_attrs %{some_var: "I'm some variable, don't mind me."}

  test "create_changeset with valid attributes" do
    changeset = Order.create_changeset(%Order{}, @valid_attrs)
    assert changeset.valid?
  end

  test "create_changeset with invalid attributes" do
    changeset = Order.create_changeset(%Order{}, @invalid_attrs)
    refute changeset.valid?
  end

  test "update_changeset with valid attributes" do
    changeset = Order.update_changeset(%Order{}, @valid_attrs)
    assert changeset.valid?
  end

  test "update_changeset with invalid attributes" do
    changeset = Order.update_changeset(%Order{}, @invalid_attrs)
    refute changeset.valid?
  end
end
