defmodule VinculiWeb.Web.Router do
  use VinculiWeb.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug VinculiWeb.Web.Auth, user_repo: VinculiDb.Accounts
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", VinculiWeb.Web do
    pipe_through :browser # Use the default browser stack

    get "/login", AuthController, :login
    get "/signup", AuthController, :signup
    post "/create", AuthController, :create
    resources "/session", SessionController, only: [:create]
    delete "/session", SessionController, :delete
  end

  scope "/", VinculiWeb.Web do
    pipe_through [:browser, :authenticate_user]

    get "/", PageController, :index
  end

  # Other scopes may use custom stacks.
  # scope "/api", VinculiWeb.Web do
  #   pipe_through :api
  # end
end
