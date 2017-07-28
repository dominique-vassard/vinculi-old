defmodule VinculiDb.Accounts do
  alias VinculiDb.Repo
  alias VinculiDb.Accounts.User

  @moduledoc """
  The accounts context
  """

  @doc """
  Signup a user.

  ## Examples

      iex> signup_user(%{field: value})
      {:ok, %User{}}

      iex> signup_user(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def signup_user(user_params) do
    %User{}
    |> User.user_signup_changeset(user_params)
    |> Repo.insert()
  end

  @doc """
  Gets a single user.

  Raises `Ecto.NoResultsError` if the User does not exist.

  ## Examples

      iex> get_user!(123)
      %User{}

      iex> get_user!(456)
      ** (Ecto.NoResultsError)

  """
  def get_user!(user_id) do
    Repo.get!(User, user_id)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking user changes.

  ## Examples

      iex> change_user(user)
      %Ecto.Changeset{source: %User{}}

  """
  def change_user(%User{} = user) do
    User.changeset(user, %{})
  end
end