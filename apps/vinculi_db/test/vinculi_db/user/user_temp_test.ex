defmodule VinculiDb.User.UserRepoTest do
  use VinculiDb.SupportCase
  alias VinculiDb.User.UserTemp
  alias VinculiDb.User.User

  test "Add a user to database" do
    attrs = %{first_name: "John", last_name: "Duff",
                  email: "john.duff@email.com", pass: "Gr34tPass!"}
    assert {:ok, insert_result} = UserTemp.add(attrs)
    IO.puts inspect insert_result

    result = Map.put(insert_result, :pass, nil)

    res = Repo.get_by!(User, first_name: "John")
    assert res == result
  end
end