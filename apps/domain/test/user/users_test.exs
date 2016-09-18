defmodule UsersTest do
  @moduledoc false

  use ExUnit.Case, async: true
  alias Domain.{Users}

  setup do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(Domain.Repo)
  end

  @valid_attrs %{email: "admin@test.com", first_name: "Admin",
                   last_name: "Test", password: "password"}
  @invalid_attrs %{}

  test "create a User with valid params" do
    user = Users.create_user!(@valid_attrs)

    assert user.id
  end

  test "get a user by params" do
    Users.create_user!(@valid_attrs)
    user = Users.find_by_params(email: @valid_attrs.email)

    assert user.first_name == @valid_attrs.first_name
  end

  test "change a user sucessfully" do
    user = Users.create_user!(@valid_attrs)
    Users.edit_user(user.id, %{email: "new-email@email.com"})

    edited_user = Users.find_by_params(first_name: @valid_attrs.first_name)

    assert edited_user.email == "new-email@email.com"
  end

  test "delete a user successfully" do
    user = Users.create_user!(@valid_attrs)
    Users.delete_user(user.id)

    assert length(Users.all) == 0
  end
end
