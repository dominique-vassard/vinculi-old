defmodule VinculiDb.User.UserRepoTest do
  use VinculiDb.SupportCase
  alias VinculiDb.User.User

  test "Add a user to database" do
    attrs = %{first_name: "John", last_name: "Duff",
                  email: "john.duff@email.com", pass: "Gr34tPass!",
                  pass_confirmation: "Gr34tPass!"}
    changeset = User.user_signup_changeset %User{}, attrs

    assert {:ok, insert_result} = Repo.insert changeset

    # pass is a virtual field, and cannot be extracted from database
    result = Map.merge(insert_result, %{pass: nil, pass_confirmation: nil})
    res = Repo.get_by!(User, first_name: "John")
    assert res == result
  end
end