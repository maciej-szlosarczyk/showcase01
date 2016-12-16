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
    |> cast(params, [:rate, :date])
    |> validate_required([:rate, :date])
  end
end
