defmodule TimesTest do
  use ExUnit.Case
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
end
