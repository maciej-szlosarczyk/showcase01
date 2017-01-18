defmodule Domain.Dates do
  @moduledoc false

  def to_date(date) do
    date
    |> replace_if_needed
    |> String.split("-")
    |> Enum.map(fn(x) -> String.to_integer(x) end)
    |> normalize_if_needed
    |> List.to_tuple
    |> Ecto.Date.cast!
  end

  def to_date(date, type) when type == :american do
    date
    |> replace_if_needed
    |> String.split("-")
    |> Enum.map(fn(x) -> String.to_integer(x) end)
    |> normalize_if_needed
    |> un_americanize
    |> List.to_tuple
    |> Ecto.Date.cast!
  end

  defp replace_if_needed(string) do
    case String.match?(string, ~r/\./) do
      true ->
        String.replace(string, ".", "-")
      _    ->
        true
    end
  end

  defp normalize_if_needed([a, b, c]) do
    case [a, b, c] do
      [x, y, z] when z > y and z > x ->
        Enum.reverse([a, b, c])
      _ ->
        [a, b, c]
    end
  end

  defp un_americanize([a, b, c]) do
    [a, c, b]
  end

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
