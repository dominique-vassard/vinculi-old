defmodule VinculiWeb.Web.PageController do
  use VinculiWeb.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
