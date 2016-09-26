defmodule Domain.Order do
  @moduledoc false

  @currency_choices ["AUD", "BGN", "BRL", "CAD", "CHF", "CNY", "CZK", "DKK", "EUR", "GBP", "HKD", "HRK", "HUF", "IDR", "ILS", "INR", "JPY", "KRW", "MXN", "MYR", "NOK", "NZD", "PHP", "PLN", "RON", "RUB", "SEK","SGD", "THB", "TRY", "USD", "ZAR"]

  use Ecto.Schema
  import Ecto.Changeset

  schema "orders" do
    field :base_currency, :string, null: false
    field :target_currency, :string, null: false
    field :amount, :decimal, null: false
    field :start_date, Ecto.Date, null: false
    field :end_date, Ecto.Date, null: false
    belongs_to :user, Domain.User

    timestamps()
  end

  def currency_choices do
    @currency_choices
  end

  def create_changeset(order, params \\ %{}) do
    order
    |> cast(params, [:base_currency, :target_currency, :amount, :end_date])
    |> validate_inclusion(:base_currency, currency_choices)
    |> validate_inclusion(:target_currency, currency_choices)
    |> validate_required([:base_currency, :target_currency, :amount, :end_date])
  end
end
