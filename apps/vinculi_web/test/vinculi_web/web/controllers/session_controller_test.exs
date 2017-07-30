defmodule VinculiWeb.Web.SessionControllerTest do
  use VinculiWeb.Web.ConnCase

  # setup %{conn: conn} do
  #   user = user_fixture()
  #   # conn =
  #   #   build_conn()
  #   #   |> bypass_through(VinculiWeb.Web.Router, :browser)
  #   #   |> get("/login")
  #   # new_conn = assign conn, :current_user, user
  #   # put_session new_conn, :user_id, user.id
  #   {:ok, conn: conn, user: user}
  # end

  test "create/2 with valid credentials redirects to index", %{conn: conn} do
    user =user_fixture()
    create_conn = post conn, session_path(conn, :create),
                  session: %{email: user.email, pass: user.pass}

    assert redirected_to(create_conn) == page_path(create_conn, :index)
  end

  test "create/2 with invalid credenitals put a flash", %{conn: conn} do
    user =user_fixture()
    create_conn = post conn, session_path(conn, :create),
                  session: %{email: "not-exists@fail.com", pass: user.pass}
    assert get_flash(create_conn, :error) == "Invalid credentials"
    assert redirected_to(create_conn) == auth_path(create_conn, :login)
  end

  test "delete/2 redirects to login", %{conn: conn} do
    user =user_fixture()
    create_conn = post conn, session_path(conn, :create),
                  session: %{email: user.email, pass: user.pass}

    del_conn = delete create_conn, session_path(create_conn, :delete), id: user.id

    assert redirected_to(del_conn) == auth_path(del_conn, :login)
  end
end