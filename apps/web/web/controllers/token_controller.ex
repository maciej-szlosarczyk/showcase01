defmodule Web.TokenController do
  @moduledoc false

  use Web.Web, :controller

  def unauthenticated(conn, _params) do
    conn
    |> put_flash(:info, "You must be signed in to acess this page.")
    |> redirect(to: session_path(conn, :new))
  end

  def unauthorized(conn, _params) do
    conn
    |> put_flash(:error, "You must be signed in to acess this page.")
    |> redirect(to: session_path(conn, :new))
  end
end
