defmodule RatesTest do
  @moduledoc false

  alias Domain.Repo
  alias Ecto.Adapters.SQL.Sandbox

  use ExUnit.Case, async: true

  setup do
    :ok = Sandbox.checkout(Repo)
  end
end
