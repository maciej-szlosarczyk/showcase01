defmodule UserTest do
  @moduledoc false

  use ExUnit.Case

  alias Domain.User

  @valid_attrs %{email: "admin@test.com", first_name: "Admin", last_name: "Test", password: "password"}
  @invalid_attrs %{}

  test "create_changeset with valid attributes" do
    changeset = User.create_changeset(%User{}, @valid_attrs)
    assert changeset.valid?
  end

  test "create_changeset with invalid attributes" do
    changeset = User.create_changeset(%User{}, @invalid_attrs)
    refute changeset.valid?
  end

  test "update_changeset with valid attributes" do
    changeset = User.update_changeset(%User{}, @valid_attrs)
    assert changeset.valid?
  end

  test "update_changeset with invalid attributes" do
    changeset = User.update_changeset(%User{}, @invalid_attrs)
    refute changeset.valid?
  end
end
