defmodule VinculiWeb.Web.AuthControllerTest do
  use VinculiWeb.Web.ConnCase

  @valid_user_attrs %{first_name: "John", last_name: "Duff",
                      email: "john.duff@email.com", pass: "Str0ng!On3",
                      pass_confirmation: "Str0ng!On3"}

  describe "signup/2:" do
    test "has all required signup fields", %{conn: conn} do
      conn = get conn, auth_path(conn, :signup)
      content = html_response(conn, 200)
      assert content =~ "user_first_name"
      assert content =~ "user_last_name"
      assert content =~ "user_email"
      assert content =~ "user_pass"
      assert content =~ "user_pass_confirmation"
    end

  end

  describe "create/2:" do
    test "Redirect to signup and shows error if  invalid", %{conn: conn} do
      invalid_attrs = Map.put(@valid_user_attrs, :pass, "invalid")
      conn = post conn, auth_path(conn, :create), user: invalid_attrs
      content = html_response(conn, 200)
      assert content =~ "An error occured. Please check the errors below."
    end

    test "Redirect to index if everything and put a flash", %{conn: conn} do
      conn = post conn, auth_path(conn, :create), user: @valid_user_attrs
      assert redirected_to(conn) == page_path(conn, :index)
    end
  end

  test "login/2 has all required fields", %{conn: conn} do
    conn = get conn, auth_path(conn, :login)
    content = html_response(conn, 200)
    assert content =~ "session_email"
    assert content =~ "session_pass"
  end
end