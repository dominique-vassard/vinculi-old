defmodule VinculiWeb.Web.AuthTest do
  use VinculiWeb.Web.ConnCase
  alias VinculiWeb.Web.Auth

  test "authenticate user halts if there is no current_user", %{conn: conn} do
    conn =
    conn
    |> assign(:current_user, nil)
    |> Auth.authenticate_user([])
    assert redirected_to(conn) == auth_path(conn, :login)
    assert conn.halted
  end

  test "authenticate_user doesn't halt if there is a current user id",
    %{conn: conn} do

    conn =
    conn
    |> assign(:current_user, %VinculiDb.User.User{})
    |> Auth.authenticate_user([])

    refute conn.halted
  end
end