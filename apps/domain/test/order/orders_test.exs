defmodule OrdersTest do
  @moduledoc false

  Code.require_file "test/support/domain_factory.ex"

  alias Domain.{Orders, Repo, Factory}
  alias Ecto.Adapters.SQL.Sandbox
  alias Ecto.Date

  use ExUnit.Case, async: true

  setup do
    :ok = Sandbox.checkout(Repo)
  end

  {new_date, _} = :calendar.now_to_datetime(:os.timestamp)

  @valid_attrs %{base_currency: "EUR", target_currency: "GBP", amount: 1200,
                 end_date: Date.cast!(new_date), user_id: nil}

  @invalid_attrs %{some_var: "I'm some invalid variable, don't mind me."}

  test "create_order!" do
    user = Factory.insert(:user)
    new_map = %{@valid_attrs | user_id: user.id}
    {_, order} = Orders.create_order!(new_map)

    assert order == Orders.find_by_params(amount: 1200)
  end

  test "invalid create_order!" do
    {status, _} = Orders.create_order!(@invalid_attrs)

    assert status == :error
  end

  test "filter_by_user" do
    user = Factory.insert(:user)
    new_map = %{@valid_attrs | user_id: user.id}
    {_, order} = Orders.create_order!(new_map)

    assert Orders.filter_by_user(user.id) == [order]

    assert Orders.all == [order]
  end

  test "build_order" do
    changeset = Orders.build_order

    refute changeset.valid?
    assert changeset.required == [:base_currency, :target_currency, :amount,
                                  :end_date, :user_id]
  end

  test "update_order" do
    changeset = Orders.update_order

    refute changeset.valid?
    assert changeset.required == [:base_currency, :target_currency, :amount,
                                  :end_date, :user_id]
  end
end
