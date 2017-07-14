defmodule VinculiApi.Web.Router do
  use VinculiApi.Web, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", VinculiApi.Web do
    pipe_through :api
  end
end
