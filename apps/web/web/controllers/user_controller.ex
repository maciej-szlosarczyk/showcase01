defmodule Web.UserController do
  @moduledoc false

  use Web.Web, :controller
  alias Domain.Users

  def index(conn, _params) do
    users = Users.all
    render(conn, "index.html", users: users)
  end

  def new(conn, _params) do
    changeset = Users.build_user
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"user" => user_params}) do
    case Users.create_user!(user_params) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "User created successfully")
        |> redirect(to: user_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
      true ->
        IO.puts "Something went wrong"
    end
  end
end
