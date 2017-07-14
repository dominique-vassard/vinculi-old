defmodule VinculiApi.Web.Router do
  use VinculiApi.Web, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", VinculiApi.Web do
    pipe_through :api

    get "/metadata/node/labels", MetadataController, :node_labels
  end
end
