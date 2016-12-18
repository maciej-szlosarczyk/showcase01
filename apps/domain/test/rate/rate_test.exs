defmodule RateTest do
  @moduledoc """
  As you possibly know, I shouldn't be empty.
  But I am not.
  """

  alias Domain.Repo
  alias Ecto.Adapters.SQL.Sandbox
  alias Ecto.Date

  use ExUnit.Case, async: true

  setup do
    :ok = Sandbox.checkout(Repo)
  end

  alias Domain.Rate

  @valid_attrs %{data: %{base: "eur", date: "2016-12-16",
                        rates: %{aud: 1.4239, bgn: 1.9558, brl: 3.5081,
                                cad: 1.396,chf: 1.0751, cny: 7.2635,
                                czk: 27.021, dkk: 7.434, gbp: 0.8389,
                                hkd: 8.1032, hrk: 7.536, huf: 312.45,
                                idr: 13977.82, ils: 4.0425, inr: 70.7765,
                                jpy: 123.38, krw: 1239.53, mxn: 21.2528,
                                myr: 4.6715, nok: 9.0623,nzd: 1.4892,
                                php: 52.193, pln: 4.42, ron: 4.5165,
                                rub: 64.3017, sek: 9.789, sgd: 1.5065,
                                thb: 37.413, try: 3.6601, usd: 1.0439,
                                zar: 14.5876
                        }
                       },
                 date: Date.cast!("2016-12-16")
  }

  @invalid_base %{data: %{base: "not_eur", date: "2016-12-16",
                          rates: %{aud: 1.4239, bgn: 1.9558, brl: 3.5081,
                                   cad: 1.396,chf: 1.0751, cny: 7.2635,
                                   czk: 27.021, dkk: 7.434, gbp: 0.8389,
                                   hkd: 8.1032, hrk: 7.536, huf: 312.45,
                                   idr: 13977.82, ils: 4.0425, inr: 70.7765,
                                   jpy: 123.38, krw: 1239.53, mxn: 21.2528,
                                   myr: 4.6715, nok: 9.0623,nzd: 1.4892,
                                   php: 52.193, pln: 4.42, ron: 4.5165,
                                   rub: 64.3017, sek: 9.789, sgd: 1.5065,
                                   thb: 37.413, try: 3.6601, usd: 1.0439,
                                   zar: 14.5876
                          }
                         },
                  date: Date.cast!("2016-12-16")
  }

    @invalid_keys %{data: %{base: "eur", date: "2016-12-16",
                          rates: %{aud: 1.4239, bgn: 1.9558, brl: 3.5081,
                                   cad: 1.396,chf: 1.0751, cny: 7.2635,
                                   surprise: 27.021, dkk: 7.434, gbp: 0.8389,
                                   hkd: 8.1032, hrk: 7.536, huf: 312.45,
                                   idr: 13977.82, ils: 4.0425, inr: 70.7765,
                                   jpy: 123.38, krw: 1239.53, mxn: 21.2528,
                                   myr: 4.6715, nok: 9.0623,nzd: 1.4892,
                                   php: 52.193, pln: 4.42, ron: 4.5165,
                                   rub: 64.3017, sek: 9.789, sgd: 1.5065,
                                   thb: 37.413, try: 3.6601, usd: 1.0439,
                                   zar: 14.5876
                          }
                         },
                  date: Date.cast!("2016-12-16")
  }

  describe "data map positive flows" do
    test "allow to contain specific attributes" do
      changeset = Rate.create_changeset(%Rate{}, @valid_attrs)
      assert(changeset.valid?)
    end
  end

  describe "data map negative flows" do
    test "disallow data.base that's different than 'eur'" do
      changeset = Rate.create_changeset(%Rate{}, @invalid_base)
      assert(changeset.errors == [data: {"Base cannot be different than 'eur'", []}])
    end

    test "disallow non-currency keys in rates" do
      changeset = Rate.create_changeset(%Rate{}, @invalid_keys)
      assert(changeset.errors == [data: {"Rates cannot contain non-currency keys", []}])
     end
  end
end
