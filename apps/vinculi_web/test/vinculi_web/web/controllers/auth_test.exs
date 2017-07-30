defmodule VinculiWeb.Web.AuthTest do
  use VinculiWeb.Web.ConnCase, async: true

  alias VinculiWeb.Web.Auth
  alias VinculiDb.Accounts
  alias VinculiDb.Accounts.User

  setup %{conn: _conn} do
    conn =
      build_conn()
      |> bypass_through(VinculiWeb.Web.Router, :browser)
      |> get("/")

    {:ok, %{conn: conn}}
  end

  test "call/2 put valid found user in assigns", %{conn: conn} do
    user = user_fixture()
    user_wo_virtual = Map.merge(user, %{pass: nil, pass_confirmation: nil})

    call_conn =
      conn
      |> put_session(:user_id, user.id)
      |> Auth.call(Accounts)
    assert call_conn.assigns.current_user == user_wo_virtual
  end

  test "call/2 with no session put nil in assigns", %{conn: conn} do
    call_conn = Auth.call(conn, Accounts)
    assert call_conn.assigns.current_user == nil
  end

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
      |> assign(:current_user, %VinculiDb.Accounts.User{})
      |> Auth.authenticate_user([])

    refute conn.halted
  end

  test "login/2 add user in session", %{conn: conn} do
    user = user_fixture()

    login_conn =
      conn
      |> Auth.login(%User{id: user.id})
      |> send_resp(:ok, "")

    next_conn = get login_conn, "/"
    assert get_session(next_conn, :user_id) == user.id
  end

  test "logout/1 cleans session from user data", %{conn: conn} do
    logout_conn =
      conn
      |> put_session(:user_id, 123)
      |> assign(:current_user, %User{id: 123})
      |> Auth.logout()
    next_conn = get logout_conn, "/"
    refute get_session(next_conn, :user_id) == 123
  end
end