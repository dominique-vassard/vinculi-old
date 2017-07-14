defmodule VinculiDb.TestPassword do
  use VinculiDb.SupportCase
  alias VinculiDb.Password

  test "Cannot generate password with less than 4 characters" do
    assert_raise ArgumentError, fn -> Password.generate(3) end
  end

  test "Cannot generate password with more than 100 characters" do
    assert_raise ArgumentError, fn -> Password.generate(101) end
  end

  test "generated has a correct length and format" do
    for _ <- 1..100 do
      password_len = 3 + :rand.uniform(96)
      password = Password.generate(password_len)

      assert String.length(password) == password_len,
             "Password has the correct length"
      assert Regex.run(~r/[a-z]/, password),
             "Password contains at leat one lowercase character [#{password}]"
      assert Regex.run(~r/[A-Z]/, password),
             "Password contains at leat one uppercase character [#{password}]"
      assert Regex.run(~r/[0-9]/, password),
             "Password contains at leat one digit [#{password}]"
      assert Regex.run(~r/[\W_]/, password),
             "Password contains at leat one special character  [#{password}]"
    end
  end
end