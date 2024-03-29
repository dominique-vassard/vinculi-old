defmodule VinculiApi.DatabaseCase do
  @moduledoc """
  This module defines the test case to be used by
  database (repo) tests.

  You may define functions here to be used as helpers in
  your model tests. See `errors_on/2`'s definition as reference.

  Finally, as the test case interacts with the database,
  it cannot be async. Therefore, async is not allowed.
  """

  use ExUnit.CaseTemplate

  using do
    quote do
      alias VinculiApi.BoltRepo

      import Ecto
      import Ecto.Changeset
      import Ecto.Query
      import VinculiApi.DatabaseHelpers
      import VinculiApi.TestPerson
      import VinculiApi.DatabaseCase
    end
  end

  @doc """
  Helper for returning list of errors in a struct when given certain data.

  ## Examples

  Given a User schema that lists `:name` as a required field and validates
  `:password` to be safe, it would return:

      iex> errors_on(%User{}, %{password: "password"})
      [password: "is unsafe", name: "is blank"]

  You could then write your assertion like:

      assert {:password, "is unsafe"} in errors_on(%User{},
                                                   %{password: "password"})

  You can also create the changeset manually and retrieve the errors
  field directly:

      iex> changeset = User.changeset(%User{}, password: "password")
      iex> {:password, "is unsafe"} in changeset.errors
      true
  """
  def errors_on(struct, data) do
    struct.__struct__.changeset(struct, data)
    |> Ecto.Changeset.traverse_errors(&VinculiApi.Web.ErrorHelpers.translate_error/1)
    |> Enum.flat_map(fn {key, errors} -> for msg <- errors, do: {key, msg} end)
  end
end