defmodule VinculiDb.User.UserTemp do
  alias VinculiDb.User.User
  alias VinculiDb.Repo

  def add(attrs) do
    User.user_signup_changeset(%User{}, attrs)
    |> Repo.insert()
  end
end