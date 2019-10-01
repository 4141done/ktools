defmodule Ktools.Knum do
  defstruct raw: [], ones: 0, tens: 0, hundreds: 0, thousands: 0, tens_thousands: 0

  @moduledoc """
  Documentation for Knum.
  """

  @doc """
  Takes a number written in Korean

  ## Examples

      iex> Knum.to_int("오백십일")
      511

  """
  def to_int(str_num) do
    raw_normalized =
      str_num
      |> String.replace(~r/\s+/, "")
      |> String.graphemes()

    %__MODULE__{raw: raw_normalized}
    |> do_int_conversion()
    |> to_final_int()
  end

  defp to_final_int(%__MODULE__{hundreds: hundreds, tens: tens, ones: ones, thousands: thousands, tens_thousands: tens_thousands}) do
    tens_thousands + thousands + hundreds + tens + ones
  end

  defp do_int_conversion(%{raw: []} = num), do: num

  defp do_int_conversion(%{raw: ["백", "만" | rest]} = num) do
    num
    |> Map.replace!(:tens_thousands, 1000000)
    |> Map.replace!(:raw, rest)
    |> do_int_conversion()
  end

  defp do_int_conversion(%{raw: [tens_thousands, "백", "만" | rest]} = num) do
    tens_thousands = single_num(tens_thousands) * 1000000

    num
    |> Map.replace!(:tens_thousands, tens_thousands)
    |> Map.replace!(:raw, rest)
    |> do_int_conversion()
  end

  defp do_int_conversion(%{raw: [tens_thousands, "십", "만" | rest]} = num) do
    tens_thousands = single_num(tens_thousands) * 100000

    num
    |> Map.replace!(:tens_thousands, tens_thousands)
    |> Map.replace!(:raw, rest)
    |> do_int_conversion()
  end

  defp do_int_conversion(%{raw: ["십", "만" | rest]} = num) do
    num
    |> Map.replace!(:tens_thousands, 100000)
    |> Map.replace!(:raw, rest)
    |> do_int_conversion()
  end

  defp do_int_conversion(%{raw: ["만" | rest]} = num) do
    num
    |> Map.replace!(:tens_thousands, 10000)
    |> Map.replace!(:raw, rest)
    |> do_int_conversion()
  end

  defp do_int_conversion(%{raw: [tens_thousands, "만" | rest]} = num) do
    tens_thousands = single_num(tens_thousands) * 10000

    num
    |> Map.replace!(:tens_thousands, tens_thousands)
    |> Map.replace!(:raw, rest)
    |> do_int_conversion()
  end

  defp do_int_conversion(%{raw: ["천" | rest]} = num) do
    num
    |> Map.replace!(:thousands, 1000)
    |> Map.replace!(:raw, rest)
    |> do_int_conversion()
  end

  defp do_int_conversion(%{raw: [thousands, "천" | rest]} = num) do
    thousands = single_num(thousands) * 1000

    num
    |> Map.replace!(:thousands, thousands)
    |> Map.replace!(:raw, rest)
    |> do_int_conversion()
  end

  defp do_int_conversion(%{raw: ["백" | rest]} = num) do
    num
    |> Map.replace!(:hundreds, 100)
    |> Map.replace!(:raw, rest)
    |> do_int_conversion()
  end

  defp do_int_conversion(%{raw: [hundreds, "백" | rest]} = num) do
    hundreds_value = single_num(hundreds) * 100

    num
    |> Map.replace!(:hundreds, hundreds_value)
    |> Map.replace!(:raw, rest)
    |> do_int_conversion()
  end

  defp do_int_conversion(%{raw: ["십" | rest]} = num) do
    num
    |> Map.replace!(:tens, 10)
    |> Map.replace!(:raw, rest)
    |> do_int_conversion()
  end

  defp do_int_conversion(%{raw: [tens, "십" | rest]} = num) do
    tens_value = single_num(tens) * 10

    num
    |> Map.replace!(:tens, tens_value)
    |> Map.replace!(:raw, rest)
    |> do_int_conversion()
  end

  defp do_int_conversion(%{raw: [ones]} = num) do
    num
    |> Map.replace!(:ones, single_num(ones))
    |> Map.replace!(:raw, [])
    |> do_int_conversion()
  end

  defp do_int_conversion(num), do: num

  defp single_num("일"), do: 1
  defp single_num("이"), do: 2
  defp single_num("삼"), do: 3
  defp single_num("사"), do: 4
  defp single_num("오"), do: 5
  defp single_num("육"), do: 6
  defp single_num("칠"), do: 7
  defp single_num("팔"), do: 8
  defp single_num("구"), do: 9
  defp single_num(bad_num), do: 0
end
