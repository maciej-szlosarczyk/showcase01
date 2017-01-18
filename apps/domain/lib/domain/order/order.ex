defmodule Domain.Order do
  @moduledoc false

  @currency_choices ["AUD", "BGN", "BRL", "CAD", "CHF", "CNY", "CZK", "DKK",
                     "EUR", "GBP", "HKD", "HRK", "HUF", "IDR", "ILS", "INR",
                     "JPY", "KRW", "MXN", "MYR", "NOK", "NZD", "PHP", "PLN",
                     "RON", "RUB", "SEK", "SGD", "THB", "TRY", "USD", "ZAR"]

  use Ecto.Schema
  alias Ecto.Date
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
    |> cast(params, [:base_currency, :target_currency, :amount, :end_date,
                    :start_date, :user_id])
    |> strings_to_lowercase
    |> validate_inclusion(:base_currency, currency_choices)
    |> validate_inclusion(:target_currency, currency_choices)
    |> set_start_date
    |> validate_required([:base_currency, :target_currency, :amount, :end_date,
                         :user_id])
  end

  def update_changeset(order, params \\ %{}) do
    order
    |> cast(params, [:base_currency, :target_currency, :amount, :end_date,
                    :start_date, :user_id])
    |> strings_to_lowercase
    |> validate_inclusion(:base_currency, currency_choices)
    |> validate_inclusion(:base_currency, currency_choices)
    |> set_start_date
    |> validate_required([:base_currency, :target_currency, :amount, :end_date,
                         :user_id])
  end

  def set_start_date(order) do
    {date, _} = :calendar.now_to_datetime(:os.timestamp)
    order
    |> put_change(:start_date, Date.cast!(date))
  end

  def strings_to_lowercase(order) do
    base = get_change(order, :base_currency)
    target = get_change(order, :target_currency)

    case {base, target} do
      {x, y} when is_bitstring(x) and is_bitstring(y) ->
        order
        |> put_change(:base_currency, String.upcase(x))
        |> put_change(:target_currency, String.upcase(y))
      {_, _} ->
        order
    end
  end
end
