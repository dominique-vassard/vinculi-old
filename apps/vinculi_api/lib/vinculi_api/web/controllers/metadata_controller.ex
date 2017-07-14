defmodule VinculiApi.Web.MetadataController do
  use VinculiApi.Web, :controller
  alias VinculiApi.Meta

  def node_labels(conn, _params) do
    labels = Meta.list_labels()

    json conn, labels
  end
end