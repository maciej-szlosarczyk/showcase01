defmodule Domain.Rate do
  @moduledoc false

  use Ecto.Schema
  alias Ecto.Date
  import Ecto.Changeset

  schema "rates" do
    field :data, :map, null: false
    field :date, Ecto.Date, null: false

    timestamps
  end

  def create_changeset(rate, params \\ %{}) do
    rate
    |> cast(params, [:data, :date])
    |> validate_base
    |> validate_rate_keys
    |> validate_required([:data, :date])
  end

  def validate_base(changeset) do
    validate_change(
      changeset, :data, fn(:data, data) -> equal_to_eur(:data, data) end
    )
  end

  def validate_rate_keys(changeset) do
    validate_change(
      changeset, :data, fn(:data, data) -> check_if_in_choices(:data, data) end
    )
  end

  defp equal_to_eur(:data, data) do
    if data.base != "EUR" do
      [data: "Base cannot be different than 'eur'"]
    else
      []
    end
  end

  defp check_if_in_choices(:data, data) do
    keys = Map.keys(data.rates)
    if Enum.all?(keys, fn(x) -> check_if_a_member(x) end) do
      []
    else
      [data: "Rates cannot contain non-currency keys"]
    end
  end

  defp check_if_a_member(x) do
    Enum.member?(Domain.Order.currency_choices, Atom.to_string(x))
  end
end
