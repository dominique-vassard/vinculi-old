defmodule VinculiDb.User.UserTemp do
  alias VinculiDb.User.User
  alias VinculiDb.Repo

  def add(attrs) do
    User.user_signup_changeset(%User{}, attrs)
    |> Repo.insert()
  end

  def get_by_firstname(first_name) do
    Repo.get_by!(User, first_name: first_name)
  end
end