defmodule RateTest do
  @moduledoc false

  alias Domain.Repo
  alias Ecto.Adapters.SQL.Sandbox
  alias Ecto.Date

  use ExUnit.Case, async: true

  setup do
    :ok = Sandbox.checkout(Repo)
  end

  alias Domain.Rate

  describe "data map" do
    test "allow to contain specific attributes" do
    end

    test "disallow other attributes" do
    end
  end
end
