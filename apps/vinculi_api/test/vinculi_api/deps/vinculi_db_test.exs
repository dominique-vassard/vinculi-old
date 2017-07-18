defmodule VinculiApi.Web.VinculiDbTest do
  use VinculiApi.DataCase
  alias VinculiDb.User.UserTemp

  test "Add a user to database" do
    attrs = %{first_name: "VinculiApi", last_name: "Duff",
                  email: "john.duff@email.com", pass: "Gr34tPass!"}
    assert {:ok, insert_result} = UserTemp.add(attrs)

    result = Map.put(insert_result, :pass, nil)

    res = UserTemp.get_by_firstname("VinculiApi")
    assert res == result
  end
end