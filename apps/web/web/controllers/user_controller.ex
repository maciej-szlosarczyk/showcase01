defmodule Web.UserController do
  @moduledoc false

  use Web.Web, :controller
  alias Domain.Users

  def index(conn, _params) do
    users = Users.all
    render(conn, "index.html", users: users)
  end

  def new(conn, _params) do
    render(conn, "new.html")
  end
end
