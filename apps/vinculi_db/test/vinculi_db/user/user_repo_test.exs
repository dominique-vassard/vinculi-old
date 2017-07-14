defmodule VinculiDb.User.UserRepoTest do
  use VinculiDb.SupportCase
  alias VinculiDb.User.User

  test "Add a user to database" do
    attrs = %{first_name: "John", last_name: "Duff",
                  email: "john.duff@email.com", pass: "Gr34tPass!"}
    changeset = User.user_signup_changeset %User{}, attrs

    assert {:ok, insert_result} = Repo.insert changeset

    # pass is a virtual field, and cannot be extracted from database
    result = Map.put(insert_result, :pass, nil)

    res = Repo.get_by!(User, first_name: "John")
    assert res == result
  end
end