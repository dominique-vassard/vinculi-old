defmodule VinculiDb.Accounts do
  import Comeonin.Bcrypt, only: [checkpw: 2, dummy_checkpw: 0]
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

  @doc """
  Authenticate user with email and password.

  Returns an `{:ok, user}` when successful.
  Otherwise returns a `{:error, :unauthorized}` tuple.

  ## Examples
      iex> authenticate_user_by_email_password(right_email, right_password)
      {:ok, %User{}}

      iex> authenticate_user_by_email_password(wrong_email, right_password)
      {:error, :unauthorized}

      iex> authenticate_user_by_email_password(right_email, wrong_password)
      {:error, :unauthorized}

      iex> authenticate_user_by_email_password(wrong_email, wrong_password)
      {:error, :unauthorized}
  """
  def authenticate_user_by_email_password(email, password) do
    params = %{email: email, pass: password}
    changeset = User.login_changeset(%User{}, params)

    authenticate_user_by_email_password(changeset)
  end

  defp authenticate_user_by_email_password(
    %{changes: %{email: email, pass: pass}, valid?: valid}) when valid do
    user = Repo.get_by User, email: email

    cond do
      user && checkpw(pass, user.password) ->
        {:ok, user}
      true ->
        dummy_checkpw()
        {:error, :unauthorized}
    end
  end

  defp authenticate_user_by_email_password(%{valid?: valid}) when valid == false do
    {:error, :unauthorized}
  end
end