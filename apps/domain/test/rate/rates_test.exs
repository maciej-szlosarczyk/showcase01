defmodule RatesTest do
  @moduledoc false

  alias Domain.{Rates, Rate, Repo}
  alias Ecto.Adapters.SQL.Sandbox
  alias Ecto.Date

  use ExUnit.Case, async: true

  @valid_attrs %{data: %{base: "EUR", date: "2016-12-16",
                         rates: %{AUD: 1.4239, BGN: 1.9558, BRL: 3.5081,
                                  CAD: 1.396, CHF: 1.0751, CNY: 7.2635,
                                  CZK: 27.021, DKK: 7.434, GBP: 0.8389,
                                  HKD: 8.1032, HRK: 7.536, HUF: 312.45,
                                  IDR: 13_977.82, ILS: 4.0425, INR: 70.7765,
                                  JPY: 123.38, KRW: 1239.53, MXN: 21.2528,
                                  MYR: 4.6715, NOK: 9.0623, NZD: 1.4892,
                                  PHP: 52.193, PLN: 4.42, RON: 4.5165,
                                  RUB: 64.3017, SEK: 9.789, SGD: 1.5065,
                                  THB: 37.413, TRY: 3.6601, USD: 1.0439,
                                  ZAR: 14.5876
                         }
                        },
                 date: Date.cast!("2016-12-16")
  }

  setup do
    Sandbox.checkout(Repo)

    rate = Rate.create_changeset(%Rate{}, @valid_attrs)
    Repo.insert!(rate)

    :ok
  end

  test 'get rates since a date' do
    a = Rates.get_rates_since("2016.10.10")
    rate = List.first(a)

    assert(rate.data["date"] == "2016-12-16")
    assert(rate.date == Date.cast!("2016-12-16"))
  end
end
