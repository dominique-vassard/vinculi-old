defmodule MasterProxy.Plug do
  def init(options) do
    options
  end

  def call(conn, _opts) do
    cond do
      conn.request_path =~ ~r{/api} ->
        VinculiApi.Web.Endpoint.call(conn, [])
      true ->
        VinculiWeb.Web.Endpoint.call(conn, [])
    end
  end
end