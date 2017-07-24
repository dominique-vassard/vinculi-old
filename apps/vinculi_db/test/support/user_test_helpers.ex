defmodule VinculiDb.User.UserTestHelpers do
  use ExUnit.CaseTemplate
  alias VinculiDb.User.User

  @doc """
  Get changeset for the given email
  """
  def get_changeset_from_email(email, valid_attrs) do
    attrs = Map.put(valid_attrs, :email, email)
    User.changeset(%User{}, attrs)
  end

  @doc """
  Check the email validity
  """
  def check_valid_email(email, valid_attrs) do
    changeset = get_changeset_from_email(email, valid_attrs)

    assert changeset.valid?
  end

  @doc """
  Check the email invalidity
  """
  def check_invalid_email(email, valid_attrs) do
    changeset = get_changeset_from_email(email, valid_attrs)

    refute changeset.valid?
    assert {:email, {"has invalid format", [validation: :format]}}
    in changeset.errors
  end

  @doc """
  Check the password validity
  """
  def check_valid_password(password, valid_attrs) do
    attrs = Map.merge(valid_attrs, %{pass: password,
                                     pass_confirmation: password})
    changeset = User.user_signup_changeset(%User{}, attrs)

    assert changeset.valid?
  end

  @doc """
  Check the pasword hash
  """
  def check_password_hash(changeset) do
    %{pass: pass, password: password_hash} = changeset.changes

    assert changeset.valid?
    assert password_hash
    assert Comeonin.Bcrypt.checkpw pass, password_hash
  end
end