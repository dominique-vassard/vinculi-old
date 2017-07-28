defmodule VinculiDb.Accounts.UserTempTest do
  use VinculiDb.SupportCase
  alias VinculiDb.Accounts

  test "Add a user to database" do
    attrs = %{first_name: "VinculiDb", last_name: "Duff",
                  email: "john.duff@email.com", pass: "Gr34tPass!",
                  pass_confirmation: "Gr34tPass!"}
    assert {:ok, user} = Accounts.signup_user(attrs)

    result = Map.merge(user, %{pass: nil, pass_confirmation: nil})

    res = Accounts.get_user(user.id)
    assert res == result
  end
end