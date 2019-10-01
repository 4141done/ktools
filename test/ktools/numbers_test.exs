defmodule Ktools.NumbersTest do
  use ExUnit.Case

  alias Ktools.Numbers

  describe "numbers" do
    test "handles 100" do
    assert Numbers.to_int("백") == 100
  end

  test "handles 100 with tens position" do
    assert Numbers.to_int("백십") == 110
  end

  test "handles 100 with ones position" do
    assert Numbers.to_int("백일") == 101
  end

  test "handles 100 with ones and tens position" do
    assert Numbers.to_int("백십오") == 115
  end

  test "does non 1 hundreds position" do
    assert Numbers.to_int("오백") == 500
  end

  test "does non 1 hundreds position with tens position" do
    assert Numbers.to_int("오백십") == 510
  end

  test "does non 1 hundreds position with ones position" do
    assert Numbers.to_int("오백육") == 506
  end

  test "does non 1 hundreds position with ones and tens position" do
    assert Numbers.to_int("오백이십오") == 525
  end

  test "does 1000" do
    assert Numbers.to_int("천") == 1000
  end

  test "does non 1 thousands" do
    assert Numbers.to_int("오천") == 5000
  end

  test "does non 1 thousands with 100" do
    assert Numbers.to_int("오천백") == 5100
  end

  test "does non 1 thousands with 100s and 10s" do
    assert Numbers.to_int("오천백이십") == 5120
  end

  test "does non 1 thousands with 100s and 10s and 1s" do
    assert Numbers.to_int("오천백이십오") == 5125
  end

  test "does 10000" do
    assert Numbers.to_int("만") == 10000
  end

  test "does 50000" do
    assert Numbers.to_int("오만") == 50000
  end

  test "does 56000" do
    assert Numbers.to_int("오만육천") == 56000
  end

  test "does 100000" do
    assert Numbers.to_int("십만") == 100000
  end

  test "does 500000" do
    assert Numbers.to_int("오십만") == 500000
  end

  test "does 1000000" do
    assert Numbers.to_int("백만") == 1000000
  end

  test "does 5000000" do
    assert Numbers.to_int("오백만") == 5000000
  end

  test "handles spaces" do
    assert Numbers.to_int("오 천백    이십     오") == 5125
  end
  end
end
