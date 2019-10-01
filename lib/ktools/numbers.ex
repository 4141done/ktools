defmodule Ktools.Numbers do
  alias Ktools.Knum
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
    Knum.to_int(string_num)
  end

  def bulk_to_int(convert_list) do
    convert_list
    |> Enum.map(&Knum.to_int/1)
  end
end
