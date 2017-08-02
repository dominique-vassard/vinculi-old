defmodule VinculiDb.Accounts.UserRepoTest do
  use VinculiDb.SupportCase

  alias VinculiDb.Accounts

  describe "Test users:" do
    alias VinculiDb.Accounts.User

    @valid_attrs %{first_name: "John", last_name: "Duff",
                        email: "john.duff@email.com", pass: "Str0ng!On3",
                        pass_confirmation: "Str0ng!On3"}

    def user_fixture(attrs \\ %{}) do
      {:ok, user} =
      attrs
      |> Enum.into(@valid_attrs)
      |> Accounts.signup_user()

      user
    end

    test "get_user/1 returns %User if it exists" do
      user = user_fixture()
      user_wo_virtual = Map.merge(user, %{pass: nil, pass_confirmation: nil})
      assert Accounts.get_user!(user.id) == user_wo_virtual
    end

    test "get_user/1 raises an Exception if user doesn't exist" do
      assert_raise Ecto.NoResultsError, fn ->
        Accounts.get_user!(-65987)
      end
    end

    test "signup_user/1 with valid data creates user" do
      assert {:ok, %User{} = user} = Accounts.signup_user(@valid_attrs)
      assert %{first_name: "John", last_name: "Duff",
                      email: "john.duff@email.com", pass: "Str0ng!On3",
                      pass_confirmation: "Str0ng!On3"} = user
      assert Accounts.get_user!(user.id)
    end

    test "signup_user/1 with invalid data returns changeset error" do
      attrs = Map.put(@valid_attrs, :pass_confirmation, "bad_confirm")

      assert {:error, _changeset} = Accounts.signup_user(attrs)
    end

    test "change_user/1 returns a user changeset" do
      user = user_fixture()
      assert %Ecto.Changeset{} = Accounts.change_user(user)
    end

    test "authenticate_user_by_email_password/2 with valid credentials" do
      user = user_fixture()
      %User{email: email, pass: pass} = user
      assert {:ok, auth_user} =
        Accounts.authenticate_user_by_email_password(email, pass)
      user_wo_virtual = Map.merge(user, %{pass: nil, pass_confirmation: nil})
      assert auth_user == user_wo_virtual
    end

    test "authenticate_user_by_email_password/2 with invalid email" do
      %User{pass: pass} = user_fixture()
      assert {:error, :unauthorized} =
        Accounts.authenticate_user_by_email_password("not-exist@null.fr", pass)
    end

    test "authenticate_user_by_email_password/2 with invalid password" do
      %User{email: email} = user_fixture()
      assert {:error, :unauthorized} =
        Accounts.authenticate_user_by_email_password(email, "N0t_Ex1st")
    end

    test "authenticate_user_by_email_password/2 with both invalid creds" do
      user_fixture()
      assert {:error, :unauthorized} =
        Accounts.authenticate_user_by_email_password("not-exist@null.fr",
                                                     "N0t_Ex1st")
    end

    test "authenticate_user_by_email_password/2 with wrong changeset" do
      user_fixture()
      assert {:error, :unauthorized} =
        Accounts.authenticate_user_by_email_password("invalid_email",
                                                     "N0t_Ex1st")
    end
  end



end