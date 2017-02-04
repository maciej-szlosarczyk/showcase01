defmodule DatesTest do
  @moduledoc false

  alias Ecto.Date
  use ExUnit.Case, async: true

  alias Domain.Dates

  describe "Date operations" do
    test "sucessfully parse European date from a string" do
      date = "11.11.2011"
      tuple = {2011, 11, 11}
      expected_date = Date.cast!(tuple)

      assert(Dates.to_date(date) == expected_date)
    end

    test "successfully parse date with -" do
      date = "11-11-2011"
      tuple = {2011, 11, 11}
      expected_date = Date.cast!(tuple)

      assert(Dates.to_date(date) == expected_date)
    end

    test "successfully parse American date from a string" do
      date = "09.11.2001"
      tuple = {2001, 09, 11}
      expected_date = Date.cast!(tuple)

      assert(Dates.to_date(date, :american) == expected_date)
    end

    test "Given a date, return the date for the first day of the week" do
      date = Date.cast!({2011, 09, 10})
      expected_date = Date.cast!({2011, 09, 4})

      assert(Dates.wednesdize(date) == expected_date)
    end
  end
end
