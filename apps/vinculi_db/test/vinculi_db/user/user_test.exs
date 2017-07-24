defmodule VinculiDb.User.UserTest do
  use VinculiDb.SupportCase, async: true
  import VinculiDb.User.UserTestHelpers
  alias VinculiDb.User.User

  @valid_attrs %{email: "gOOd1-email@domain.com"}
  @invalid_attrs %{}

  @valid_user_attrs %{first_name: "John", last_name: "Duff",
                      email: "john.duff@email.com", pass: "Str0ng!On3"}

  test "general changeset with valid attributes" do
    changeset = User.changeset(%User{}, @valid_attrs)
    assert changeset.valid?
  end

  test "general changeset with invalid attributes" do
    changeset = User.changeset(%User{}, @invalid_attrs)
    refute changeset.valid?
  end

  test "email should not accept invalid format" do
    emails = ["ugl:yemail@wrongformat", "@missing-part1.com", "missing-part12",
             "missing@part3", "invalid@c_h_a_r", "invalid@dom.co;uk",
             "invalid@dom.co..uk"]
    Enum.map(emails, &(check_invalid_email(&1, @valid_attrs)))
  end

  test "email should accept valid format" do
    emails = ["email@domain.com", "named_email@domain.com", "email@dom.co.uk",
             "email-hyphen@domain.com", "email+plus@domain.com", "c9@dom9.com",
             "email@dom-ain.co.uk"]
    Enum.map(emails, &(check_valid_email(&1, @valid_attrs)))
  end

  test "email should be downcased" do
    cased_email = "CAsed_EmaIl@DOmAin.COm"
    attrs = Map.put(@valid_attrs, :email, cased_email)
    changeset = User.changeset(%User{}, attrs)

    assert changeset.valid?
    assert changeset.changes.email == String.downcase(cased_email)
  end

  test "user changeset with valid attributes" do
    changeset = User.user_changeset(%User{}, @valid_user_attrs)
    assert changeset.valid?
  end

  test "user changeset with invalid attributes" do
    changeset = User.user_changeset(%User{}, @invalid_attrs)
    refute changeset.valid?
  end

  test "first_name should be at least 3 chars long" do
    attrs = Map.put(@valid_user_attrs, :first_name, "Oi")
    changeset = User.user_changeset(%User{}, attrs)

    refute changeset.valid?
    assert {:first_name, {"should be at least %{count} character(s)",
                          [count: 3, validation: :length, min: 3]}}
           in changeset.errors
  end

  test "first_name should be less 40 chars long" do
    attrs = Map.put(@valid_user_attrs, :first_name, String.duplicate("a", 50))
    changeset = User.user_changeset(%User{}, attrs)

    refute changeset.valid?
    assert {:first_name, {"should be at most %{count} character(s)",
                          [count: 40, validation: :length, max: 40]}}
           in changeset.errors
  end

  test "last_name should be at least 3 chars long" do
    attrs = Map.put(@valid_user_attrs, :last_name, "Oi")
    changeset = User.user_changeset(%User{}, attrs)

    refute changeset.valid?
    assert {:last_name, {"should be at least %{count} character(s)",
                          [count: 3, validation: :length, min: 3]}}
           in changeset.errors
  end

  test "last_name should be less 40 chars long" do
    attrs = Map.put(@valid_user_attrs, :last_name, String.duplicate("a", 50))
    changeset = User.user_changeset(%User{}, attrs)

    refute changeset.valid?
    assert {:last_name, {"should be at most %{count} character(s)",
                          [count: 40, validation: :length, max: 40]}}
           in changeset.errors
  end

  describe "Check user signup" do
    test "password is valid" do
      passes = ["v4l1d_Pass", "L0nGP4assw0Rd1sL0ng!"]

      Enum.map passes, &(check_valid_password(&1, @valid_user_attrs))
    end

    test "password should be at least 8 characters long" do
      attrs = Map.put(@valid_user_attrs, :pass, "Sh0rt!")
      changeset = User.user_signup_changeset(%User{}, attrs)

      refute changeset.valid?
      assert {:pass, {"should be at least %{count} character(s)",
                          [count: 8, validation: :length, min: 8]}}
        in changeset.errors
    end

    test "password should be less than 20 characters long" do
      attrs = Map.put(@valid_user_attrs, :pass,
                      "Sh0rt!" <> String.duplicate("a", 20))
      changeset = User.user_signup_changeset(%User{}, attrs)

      refute changeset.valid?
      assert {:pass, {"should be at most %{count} character(s)",
                             [count: 20, validation: :length, max: 20]}}
        in changeset.errors
    end

    test "a valid password hash is generated" do
      User.user_signup_changeset(%User{}, @valid_user_attrs)
      |> check_password_hash()
    end
  end

  describe "Check password: " do
    test "password should contain at least one lowercase character" do
      attrs = Map.put(@valid_user_attrs, :pass, "N0LOWERC4SE!")
      changeset =
        change(%User{}, attrs)
        |> User.validate_password()

      refute changeset.valid?
      assert {:pass, {"should contains at least one lowercase character.",
                      [validation: :format]}}
          in changeset.errors
    end

    test "password should contain at least one uppercase character" do
      attrs = Map.put(@valid_user_attrs, :pass, "noupp3rc4se!")
      changeset =
        change(%User{}, attrs)
        |> User.validate_password()

      refute changeset.valid?
      assert {:pass, {"should contains at least one uppercase character.",
                      [validation: :format]}}
          in changeset.errors
    end
    test "password should contain at least one digit" do
      attrs = Map.put(@valid_user_attrs, :pass, "NoDigits!")
      changeset =
        change(%User{}, attrs)
        |> User.validate_password()

      refute changeset.valid?
      assert {:pass, {"should contains at least one digit.",
                      [validation: :format]}}
          in changeset.errors
    end

    test "password should contain at least one special character" do
      attrs = Map.put(@valid_user_attrs, :pass, "NoSpeci4alCh4r")
      changeset =
        change(%User{}, attrs)
        |> User.validate_password()

      refute changeset.valid?
      assert {:pass, {"should contains at least one special character.",
                      [validation: :format]}}
          in changeset.errors
    end
  end

  test "a valid password hash is generated" do
      change(%User{}, pass: "v4l1d_Pass")
      |> User.put_password_hash()
      |> check_password_hash()
  end
end