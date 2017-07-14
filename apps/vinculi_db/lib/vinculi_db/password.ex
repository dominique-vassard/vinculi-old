defmodule VinculiDb.Password do
  @moduledoc """
  Password generation

  Generate password with a length between 4 and 100 characters.

  Generated passwords contain:
  - at least one lowercase character
  - at least one uppercase character
  - at least one digit
  - at least one special character
  """

  @lower Enum.map ?a..?z, &to_string([&1])
  @upper Enum.map ?A..?Z, &to_string([&1])
  @digit Enum.map ?0..?9, &to_string([&1])
  @special ~S"""
!"#$%&'()*+,-./:;<=>?@[]^_{|}~
"""
|> String.codepoints
|> List.delete_at(-1)
  @all @lower ++ @upper ++ @digit ++ @special

  @doc """
    Cannot generate a password with less than 4 cahracters
  """
  def generate(len) when len < 4 do
    message = "Cannot generate passwords with less than 4 characters"
    raise %ArgumentError{message: message}
  end

  @doc """
    Cannot generate a password with less than 100 cahracters
  """
  def generate(len) when len > 100 do
    message = "Cannot generate passwords with more than 100 characters"
    raise %ArgumentError{message: message}
  end

  @doc """
  Generate a password of the given length

  ### Usage
      Password.generate(8)
  """
  def generate(len) do
    password = [Enum.random(@lower), Enum.random(@upper),
                Enum.random(@digit), Enum.random(@special)]
    generate(len - 4, password)
  end

  defp generate(0, password) do
    password
    |> Enum.shuffle()
    |> Enum.join()
  end

  defp generate(len, password) do
    generate(len - 1, [Enum.random(@all) | password])
  end

end