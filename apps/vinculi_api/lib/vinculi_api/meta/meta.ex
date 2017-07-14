defmodule VinculiApi.Meta do
  @moduledoc """
    Metadata of the graph
  """
  alias VinculiApi.BoltRepo

  alias VinculiApi.Meta.Graph
  alias VinculiApi.Meta.Node

  def list_labels() do
    BoltRepo.all(Graph.get_schema_cql())
    |> Graph.extract_node_labels()
  end
end