defmodule VinculiDb.User.UserRepoTest do
  use VinculiDb.SupportCase

  alias VinculiDb.Accounts

  @valid_user_attrs %{first_name: "John", last_name: "Duff",
                      email: "john.duff@email.com", pass: "Str0ng!On3",
                      pass_confirmation: "Str0ng!On3"}

  describe "test user signup (databse add): " do
    test "fail to insert invalid changeset" do
      attrs = Map.put(@valid_user_attrs, :pass_confirmation, "bad_confirm")

      assert {:error, _changeset} = Accounts.signup_user(attrs)
    end

    test "Successful insert with valid changeset" do
      assert {:ok, user} = Accounts.signup_user(@valid_user_attrs)
      assert %{first_name: "John", last_name: "Duff",
                      email: "john.duff@email.com", pass: "Str0ng!On3",
                      pass_confirmation: "Str0ng!On3"} = user
    end
  end


  test "Get a user" do
    {:ok, user} = Accounts.signup_user(@valid_user_attrs)

    res =  Accounts.get_user(user.id)
    assert %{first_name: "John", last_name: "Duff",
                  email: "john.duff@email.com"} = res
  end
end