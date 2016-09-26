defmodule Web.SessionController do
  @moduledoc false
  use Web.Web, :controller

  alias Guardian.Plug

  alias Web.AuthController

  def new(conn, _) do
    render conn, "new.html"
  end

  def create(conn, %{"session" => %{"email" => email, "password" => password}}) do
    case AuthController.sign_in_by_email_and_password(conn, email, password) do
      {:ok, conn} ->
        signed_in_user = Plug.current_resource(conn)
        conn
        |> put_flash(:info, "You're now signed in.")
        |> redirect(to: user_path(conn, :show, signed_in_user))
      {:error, _reason, conn} ->
        conn
        |> put_flash(:error, "Wrong email or password.")
        |> render("new.html")
    end
  end

  def delete(conn, _) do
    conn
    |> Plug.sign_out
    |> redirect(to: "/")
  end
end
