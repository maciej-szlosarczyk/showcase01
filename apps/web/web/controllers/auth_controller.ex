defmodule Web.AuthController do
#  @moduledoc false
#  user Showcase01.Web, :controller
#
#  alias Guardian.Plug
#
#  import Comeonin.Bcrypt, only: [checkpw: 2, dummy_checkpw: 0]
#
#  def signin(conn, user) do
#    conn
#    |> Plug.sign_in(user, :access)
#  end
#
#  def signin_by_email_and_password(conn, email, given_password) do
#    user = Domain.Repo.get_by(Domain.User, email: email)
#
#    cond do
#      user && checkpw(given_password, user.password_hash) ->
#        {:ok, signin(conn, user)}
#      user ->
#        {:error, :unauthorized, conn}
#      true ->
#        dummy_checkpw()
#        {:error, :not_found, conn}
#    end
#  end
end
