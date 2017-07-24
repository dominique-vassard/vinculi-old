defmodule VinculiDb.User.User do
  @moduledoc """
  Manages user data
  """
  use Ecto.Schema

  import Ecto.Changeset

  schema "users" do
    field :first_name, :string
    field :last_name, :string
    field :email, :string
    field :pass, :string, virtual: true
    field :pass_confirmation, :string, virtual: true
    field :password, :string

    timestamps()
  end

  @required_fields ~w(email)
  @user_required_fields ~w(first_name last_name)

  @doc """
  General changeset: common data
  """
  def changeset(struct, params \\ %{}) do
    email_regex = ~r/^^[\w-+.]+@[a-z0-9-]+\.[a-z]+(\.{1}[a-z]+)?$/i
    struct
    |> cast(params, @required_fields)
    |> validate_required(Enum.map @required_fields, &String.to_atom/1)
    |> validate_format(:email, email_regex)
    |> update_change(:email, &String.downcase/1)
    |> unique_constraint(:email)
  end

  @doc """
  Use changeset: for human user
  """
  def user_changeset(struct, params) do
    struct
    |> changeset(params)
    |> cast(params, @user_required_fields)
    |> validate_required(Enum.map @user_required_fields, &String.to_atom/1)
    |> validate_length(:first_name, min: 3, max: 40)
    |> validate_length(:last_name, min: 3, max: 40)
  end

  @doc """
  User signup changeset: used for user signup
  """
  def user_signup_changeset(struct, params) do
    struct
    |> user_changeset(params)
    |> cast(params, [:pass, :pass_confirmation])
    |> validate_required([:pass, :pass_confirmation])
    |> validate_length(:pass, min: 8, max: 20)
    |> validate_confirmation(:pass,
                              message: "password does not match confirmation.")
    |> validate_password()
    |> put_password_hash()
  end

  @doc """
  Computes password hash from pass
  """
  def put_password_hash(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{pass: pass}} ->
        put_change(changeset, :password, Comeonin.Bcrypt.hashpwsalt(pass))
      _ ->
        changeset
    end
  end

  @doc """
  Check the password validity

  Password should contain:
  - at least one lowercase character
  - at least one uppercase character
  - at least one digit
  - at least one special character
  """
  def validate_password(changeset) do
    changeset
    |> validate_format(:pass, ~r/[a-z]/,
          [message: "should contains at least one lowercase character."])
    |> validate_format(:pass, ~r/[A-Z]/,
          [message: "should contains at least one uppercase character."])
    |> validate_format(:pass, ~r/[\d]/,
          [message: "should contains at least one digit."])
    |> validate_format(:pass, ~r/[\W_]/,
          [message: "should contains at least one special character."])
  end
end