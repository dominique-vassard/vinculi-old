defmodule VinculiWeb.Web.VinculiDbTest do
  use VinculiWeb.DataCase
  alias VinculiDb.User.UserTemp

  test "Add a user to database" do
    attrs = %{first_name: "VinculiWeb", last_name: "Duff",
                  email: "john.duff@email.com", pass: "Gr34tPass!",
                  pass_confirmation: "Gr34tPass!"}
    assert {:ok, insert_result} = UserTemp.add(attrs)

    result = Map.merge(insert_result, %{pass: nil, pass_confirmation: nil})

    res = UserTemp.get_by_firstname("VinculiWeb")
    assert res == result
  end
end