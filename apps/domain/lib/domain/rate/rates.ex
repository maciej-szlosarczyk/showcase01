defmodule Domain.Rates do
  @moduledoc false

  alias Domain.{Rate, Repo}
  import Ecto.Query, only: [from: 2]

  def get_rates_since(date) do
    safe_date = check_date(date)

    rates =
      from r in Rate,
      where: r.date >= ^safe_date

    Repo.all(rates)
  end

  defp check_date(date) do
    {status, parsed_date} = Timex.parse(date, "%Y-%m-%d", :strftime)

    case status do
      :ok      ->
        parsed_date
      :error   ->
        raise ArgumentError, message: parsed_date
    end
  end
end
