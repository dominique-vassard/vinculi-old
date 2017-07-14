defmodule VinculiApi.DatabaseHelpers do
@moduledoc """
Helpers for database tests
"""

  alias VinculiApi.BoltRepo
  alias VinculiApi.TestPerson

  def insert_test_person(attrs = %{}) do
    changes = Map.merge(%{
      firstName: "Test_firstName",
      lastName: "Test_lastname",
      uuid: Ecto.UUID.generate()
    }, attrs)

    %TestPerson{}
      |> TestPerson.changeset(changes)
      |> BoltRepo.insert!()

    changes
  end
end