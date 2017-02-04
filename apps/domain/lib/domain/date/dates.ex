defmodule Domain.Dates do
  @moduledoc false

  alias Ecto.Date, as: Date

  @spec to_date(bitstring) :: %Ecto.Date{}
  def to_date(date) do
    date
    |> replace_if_needed
    |> String.split("-")
    |> Enum.map(fn(x) -> String.to_integer(x) end)
    |> normalize_if_needed
    |> List.to_tuple
    |> Date.cast!
  end

  @spec to_date(bitstring, atom) :: %Ecto.Date{}
  def to_date(date, type) when type == :american do
    date
    |> replace_if_needed
    |> String.split("-")
    |> Enum.map(fn(x) -> String.to_integer(x) end)
    |> normalize_if_needed
    |> un_americanize
    |> List.to_tuple
    |> Date.cast!
  end

  @spec wednesdize(%Ecto.Date{}) :: %Ecto.Date{}
  def wednesdize(date) do
    {y, m, d} = Date.to_erl(date)
    dow = :calendar.day_of_the_week({y, m, d})

    wed = case d do
            x when x >= dow ->
              d - dow + 3
            _ ->
              "Cannot compute at the moment"
          end

    Date.cast!({y, m, wed})
end

  @spec replace_if_needed(bitstring) :: bitstring
  defp replace_if_needed(string) do
    a = if String.match?(string, ~r/\./) do
      String.replace(string, ".", "-")
    end

    # Return either the new string or the old one
    a || string
  end

  @spec normalize_if_needed(list) :: list
  defp normalize_if_needed([a, b, c]) do
    case [a, b, c] do
      [x, y, z] when z > y and z > x ->
        Enum.reverse([a, b, c])
      _ ->
        [a, b, c]
    end
  end

  @spec un_americanize(list) :: list
  defp un_americanize([a, b, c]) do
    [a, c, b]
  end

  # Might be not needed, look to remove in the future
  defp check_date(date) do
    {status, parsed_date} = Timex.parse(date, "%Y-%m-%d", :strftime)

    case status do
      :ok      ->
        parsed_date
      :error   ->
        raise ArgumentError,
          message: "Cannot parse the following date: #{parsed_date}"
    end
  end
end
