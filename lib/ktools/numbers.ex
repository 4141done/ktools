defmodule Ktools.Numbers do
  @moduledoc """
  The Numbers context.
  """

  @doc """
  Converts a number written in Korean text in integer form

  ## Examples

      iex> to_int("오백십일")
      511

  """
  def to_int(string_num) do
    Ktools.Knum.to_int(string_num)
  end
end
