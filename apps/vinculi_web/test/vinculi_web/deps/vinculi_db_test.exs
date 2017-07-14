defmodule VinculiWeb.Web.VinculiDbTest do
  use VinculiWeb.DataCase
  alias VinculiDb.User.UserTemp
  alias VinculiDb.User.User
  alias VinculiDb.Repo

  test "Add a user to database" do
    attrs = %{first_name: "VinculiWeb", last_name: "Duff",
                  email: "john.duff@email.com", pass: "Gr34tPass!"}
    assert {:ok, insert_result} = UserTemp.add(attrs)

    result = Map.put(insert_result, :pass, nil)

    res = Repo.get_by!(User, first_name: "VinculiWeb")
    assert res == result
  end
end