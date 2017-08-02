defmodule VinculiWeb.Web.AuthController do
  use VinculiWeb.Web, :controller

  alias VinculiDb.Accounts.User
  alias VinculiDb.Accounts

  def login(conn, _params) do
    changeset = Accounts.change_user %User{}
    render conn, "login.html", changeset: changeset
  end

  def signup(conn, _params) do
    changeset = Accounts.change_user %User{}
    render conn, "signup.html", changeset: changeset
  end

  def create(conn, %{"user" => user_param}) do
    case Accounts.signup_user(user_param) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "Hi #{user.first_name} #{user.last_name},
                             you can login using your credentials")
        |> redirect(to: page_path(conn, :index))
      {:error, %Ecto.Changeset{} = changeset} ->
        render conn, "signup.html", changeset: changeset
    end
  end
end