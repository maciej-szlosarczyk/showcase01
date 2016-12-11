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

  defp check_date(date) do
    IO.puts date
  end
end
