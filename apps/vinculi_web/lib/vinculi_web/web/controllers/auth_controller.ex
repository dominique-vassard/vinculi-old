defmodule VinculiWeb.Web.AuthController do
  use VinculiWeb.Web, :controller
  alias VinculiDb.User.User

  def login(conn, _params) do
    render conn, "login.html"
  end

  def signup(conn, _params) do
    changeset = User.changeset %User{}
    render conn, "signup.html", changeset: changeset
  end

  def create(conn, %{"user" => user_param}) do
    case User.signup(user_param) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "Welcome #{user.first_name} #{user.last_name}")
        |> redirect(to: page_path(conn, :index))
      {:error, changeset} ->
        render conn, "signup.html", changeset: changeset
    end
  end
end