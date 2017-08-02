defmodule VinculiWeb.Web.SessionController do
  use VinculiWeb.Web, :controller

  alias VinculiWeb.Web.Auth

  alias VinculiDb.Accounts

  def create(conn, %{"session" => %{"email" =>email, "pass" => pass}}) do
    case Accounts.authenticate_user_by_email_password(email, pass) do
      {:ok, user} ->
        conn
        |> Auth.login(user)
        |> redirect(to: page_path(conn, :index))
      {:error, :unauthorized} ->
        conn
        |> put_flash(:error, "Invalid credentials")
        |> redirect(to: auth_path(conn, :login))
    end
  end

  def delete(conn, _params) do
    conn
    |> Auth.logout()
    |> redirect(to: auth_path(conn, :login))
  end
end