defmodule Domain.Rates do
  @moduledoc false

  alias Domain.{Rate, Repo}
  import Ecto.Query, only: [from: 2]

  def get_rates_since(date) do
    rates =
      from r in Rate,
      where: r.date >= ^safe_date

    Repo.all(rates)
  end
end
