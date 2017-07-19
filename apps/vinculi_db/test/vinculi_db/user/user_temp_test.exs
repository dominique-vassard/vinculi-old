defmodule VinculiDb.User.UserTempTest do
  use VinculiDb.SupportCase
  alias VinculiDb.User.UserTemp

  test "Add a user to database" do
    attrs = %{first_name: "John", last_name: "Duff",
                  email: "john.duff@email.com", pass: "Gr34tPass!"}
    assert {:ok, insert_result} = UserTemp.add(attrs)

    result = Map.put(insert_result, :pass, nil)

    res = UserTemp.get_by_firstname("John")
    assert res == result
  end
end