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

  @doc """
    Login user
  """
  def login(conn, user) do
    conn
    |> put_current_user(user)
    |> put_session(:user_id, user.id)
    |> configure_session(renew: true)
  end

  @doc """
    Logout user
  """
  def logout(conn) do
    configure_session conn, drop: true
  end

  defp put_current_user(conn, user) do
    # token = Phoenix.Token.sign(conn, "user socket", user.id)

    conn
    |> assign(:current_user, user)
    # |> assign(:user_token, token)
  end
end