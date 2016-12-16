defmodule Web.AuthController do
  @moduledoc false

  use Web.Web, :controller

  alias Guardian.Plug
  alias Domain.Users

  import Comeonin.Bcrypt, only: [checkpw: 2, dummy_checkpw: 0]

  def sign_in(conn, user) do
    conn
    |> Plug.sign_in(user, :access)
  end

  def sign_in_by_email_and_password(conn, email, given_password) do
    user = Users.find_by_params(email: email)
    cond do
      user && checkpw(given_password, user.password_hash) ->
        {:ok, sign_in(conn, user)}
      user ->
        {:error, :unauthorized, conn}
      true ->
        dummy_checkpw()
        {:error, :not_found, conn}
    end
  end
end
