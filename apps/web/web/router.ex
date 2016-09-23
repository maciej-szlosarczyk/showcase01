defmodule Web.Router do
  use Web.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :browser_session do
    plug Guardian.Plug.VerifySession
    plug Guardian.Plug.EnsureAuthenticated,
      handler: Web.TokenController
    plug Guardian.Plug.LoadResource
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Web do
      pipe_through :browser

      get "/", PageController, :index
      resources "/sessions", SessionController, only: [:new, :create, :delete]
    end

  scope "/", Web do
    pipe_through [:browser, :browser_session] #Only for authenticated
    get "/", PageController, :index
    get "/users", UserController, :index
  end


  # Other scopes may use custom stacks.
  # scope "/api", Web do
  #   pipe_through :api
  # end
end
