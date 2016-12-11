defmodule Domain.Rates do
  @moduledoc false

  alias Domain.{Order, Repo}
  import Ecto.Query, only: [from: 2]

  def get_rates_since(date) do
    rates =
      from r in Rate,
      where: r.date >= ^date

    Repo.all(rates)
  end

  def check_date(date) do
    {status, parsed_date} = Timex.parse(date, "%Y-%m-%d", :strftime)

    case status do
      :ok ->
        parsed_date
      _   ->
        {status, parsed_date}
    end
  end
end
