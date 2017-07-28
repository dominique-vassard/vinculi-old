defmodule VinculiDb.Accounts do
  alias VinculiDb.Repo
  alias VinculiDb.Accounts.User

  @moduledoc """
  Contains all access to repo for the Accounts-related stuff
  """

  @doc """
  Add new user to database
  """
  def signup_user(user_params) do
    User.user_signup_changeset(%User{}, user_params)
    |> Repo.insert()
  end

  @doc """
  Get user for the given id
  """
  def get_user(user_id) do
    Repo.get(User, user_id)
  end
end