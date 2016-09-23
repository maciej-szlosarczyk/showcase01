defmodule Web.AuthHelpers do
  @moduledoc false

  alias Guardian.Plug

  def current_user(conn), do: Plug.current_resource(conn)
  def signed_in?(conn), do: Plug.authenticated?(conn)
end
