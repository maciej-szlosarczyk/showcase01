defmodule TimesTest do
  use ExUnit.Case, async: true
  doctest Times

  test "now/0" do
    assert do
      {_, time} = :calendar.universal_time
      time == Times.now
    end   
  end

  test "now/1" do
    assert do
      {_, time} = :calendar.local_time
      time == Times.now(:local)
    end
  end

  test "calculate_offset" do
    {_, utc_time} = :calendar.universal_time
    {_, local_time} = :calendar.local_time

    IO.inspect local_time, utc_time
    assert do
      local_time - utc_time == Times.calculate_offset
    end
  end

  test "apply_offset" do
    assert do
      {_, local_time} = :calendar.local_time
      local_time == Times.apply_offset(Times.now)
    end
  end
end
