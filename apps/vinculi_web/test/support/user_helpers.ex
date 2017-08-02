defmodule VinculiWeb.Web.UserHelpers do
  alias VinculiDb.Accounts

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
end