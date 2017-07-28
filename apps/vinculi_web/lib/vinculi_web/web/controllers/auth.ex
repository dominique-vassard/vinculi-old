defmodule VinculiWeb.Web.Auth do
  import Plug.Conn
  import Phoenix.Controller

  alias VinculiWeb.Web.Router.Helpers

  @doc """
  Plug init: set user_repo
  """
  def init(opts) do
    Keyword.fetch!(opts, :user_repo)
  end

  @doc """
  Plug: put current user id in session (default: nil)
  """
  def call(conn, user_repo) do
    user_id = get_session(conn, :user_id)
    user = user_id && user_repo.get_user!(user_id)
    assign conn, :current_user, user
  end

  @doc """
  Used as plug
  Check if user is authenticated
  """
  def authenticate_user(conn, _opts) do
    if conn.assigns.current_user do
      conn
    else
      conn
      |> redirect(to: Helpers.auth_path(conn, :login))
      |> halt()
    end
  end

end