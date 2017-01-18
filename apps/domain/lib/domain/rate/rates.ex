defmodule Domain.Rates do
  @moduledoc false

  alias Domain.{Rate, Repo, Dates}
  import Ecto.Query, only: [from: 2]

  def get_rates_since(date) do
    safe_date = Dates.to_date(date)

    rates =
      from r in Rate,
      where: r.date >= ^safe_date

    Repo.all(rates)
  end
end
