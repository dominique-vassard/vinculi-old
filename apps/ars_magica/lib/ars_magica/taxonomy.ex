defmodule ArsMagica.Taxonomy do
  @moduledoc """
    Access to Ars Magica taxonomy data
  """

  @doc """
  Return the taxonomy data for the given id
  """
  def get(id) do
    query = "SELECT tid, name FROM taxonomy_term_data WHERE tid = ?"
    Ecto.Adapters.SQL.query!(ArsMagica.Repo, query, [id])
  end
end