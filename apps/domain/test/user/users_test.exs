defmodule UsersTest do
  @moduledoc false

  alias Domain.{Users, Repo}
  alias Ecto.Adapters.SQL.Sandbox

  import Ecto.Query, only: [from: 2]

  use ExUnit.Case, async: true

  setup do
    :ok = Sandbox.checkout(Repo)
  end

  @valid_attrs %{email: "admin@test.com", first_name: "Admin",
                   last_name: "Test", password: "password"}
  @invalid_attrs %{}


  describe "Success scenarios" do
    test "create a User with valid params" do
      {status, data} = Users.create_user!(@valid_attrs)

      assert status == :ok
      assert data.id
    end

    test "get a user by params" do
      Users.create_user!(@valid_attrs)
      user = Users.find_by_params(email: @valid_attrs.email)

      assert user.first_name == @valid_attrs.first_name
    end

    test "change a user sucessfully" do
      {_, user} = Users.create_user!(@valid_attrs)
      Users.edit_user(user.id, %{email: "new-email@email.com"})

      edited_user = Users.find_by_params(first_name: @valid_attrs.first_name)

      assert edited_user.email == "new-email@email.com"
    end

    test "delete a user successfully" do
      {_, user} = Users.create_user!(@valid_attrs)
      Users.delete_user(user.id)

      assert length(Users.all) == 0
    end
  end

  describe "Failure scenarios" do
    test "fail on user creation" do
      {status, data} = Users.create_user!(%{email: "I'm wrong email"})

      refute status == :ok
      refute data.valid?
    end

    test "fail on user update" do
      {_, user} = Users.create_user!(@valid_attrs)
      {status, data} = Users.edit_user(user.id, %{email: "I'm a wrong email"})

      refute status == :ok
      refute data.valid?
    end
  end

  describe "get changesets" do
    test "build_ changeset" do
      changeset = Users.build_user

      assert changeset.required == [:first_name, :last_name, :email, :password]
    end

    test "update_ changeset" do
      changeset = Users.update_user

      assert changeset.required == []
    end
  end
end
