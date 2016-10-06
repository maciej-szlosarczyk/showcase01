defmodule Times do
 @moduledoc """
  A simple module to perform time-related operations
  """

  @doc """
  Get UTC time
  """
  def now do
    {_, time} = :calendar.universal_time
    time
  end

  @doc """
  Get time in :utc or :local zone, defaults to UTC.
  """
  def now(type) do
    {_, time} =
      case type do
        :local -> :calendar.local_time
        :utc   -> :calendar.universal_time
        _      -> :calendar.universal_time
    end

    time
  end

  @doc """
  Return the difference between UTC and local time in {HH, MM, SS}
  """
  def calculate_offset do
    {_, {h, m, _}} = :calendar.local_time
    {_, {utc_h, utc_m, _}} = :calendar.universal_time

    case {h, m} do
      {x, _} when x != utc_h -> {h - utc_h, m - utc_m}
      {_, x} when x != utc_m -> {h - utc_h, m - utc_m}
    end
  end

  @doc """
  Apply local time offset to UTC time
  """
  def apply_offset(utc_time) do
    {h, m, s} = utc_time
    {offset_h, offset_m} = calculate_offset

    {h + offset_h, m + offset_m, s}
  end
end
