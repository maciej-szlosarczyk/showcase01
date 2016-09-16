defmodule Showcase01.Web.PageController do
  use Showcase01.Web.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
