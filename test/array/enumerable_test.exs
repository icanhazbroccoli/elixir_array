defmodule ArrayEnumerableTest do
  use ExUnit.Case
  doctest Array.Enumerable

  test "count" do
    assert Enum.count(Array.from_list_bool([true, true, false])) == 3
    assert Enum.count(Array.from_list_uint16([1,2,3,4,5])) == 5
    assert Enum.count(Array.from_list_float32([1.0, -1.0, -10.0, 42.0])) == 4
    assert Enum.count(Array.from_list_float64([0.0, 0.12345456567, -10.0])) == 3
    assert Enum.count(Array.from_list_int16([1, 2, 3, -1, -2, -3])) == 6
    assert Enum.count(Array.from_list_int32([0, 0, -1, 0, 123456789])) == 5
    assert Enum.count(Array.from_list_int64([0, 0, 1, 0, -123456789])) == 5
    assert Enum.count(Array.from_list_uint32([1, 10, 0, 5, 42])) == 5
    assert Enum.count(Array.from_list_uint64([0, 0, 0, 1])) == 4
  end

  test "member?" do
    assert Enum.member?(Array.from_list_bool([true, true, false]), true)
    assert Enum.member?(Array.from_list_bool([true, true, false]), false)

    assert Enum.member?(Array.from_list_uint16([1, 2, 3]), 2)
    assert Enum.member?(Array.from_list_uint32([1, 2, 3]), 2)
    assert Enum.member?(Array.from_list_uint64([1, 2, 3]), 2)
    assert Enum.member?(Array.from_list_int16([1, -2, 3]), -2)
    assert Enum.member?(Array.from_list_int32([1, -2, 3]), -2)
    assert Enum.member?(Array.from_list_int64([1, -2, 3]), -2)
    assert Enum.member?(Array.from_list_float32([1.0, -2.0, -3.1]), -2.0)
    assert Enum.member?(Array.from_list_float64([1.0, -2.0, -3.1]), -3.1)
  end

  test "reduce" do
    assert Enum.reduce(Array.from_list_bool([true, false, true]), true, fn x, acc -> acc && x end) == false
    assert Enum.reduce(Array.from_list_bool([true, false, true]), false, fn x, acc -> acc || x end) == true
    assert Enum.reduce(Array.from_list_uint16([1,2,3]), fn x, acc -> acc * x end ) == 6
    assert Enum.reduce(Array.from_list_uint32([1,2,3]), fn x, acc -> acc * x end ) == 6
    assert Enum.reduce(Array.from_list_uint64([1,2,3]), fn x, acc -> acc * x end ) == 6
    assert Enum.reduce(Array.from_list_int16([1,-2,3]), fn x, acc -> acc * x end ) == -6
    assert Enum.reduce(Array.from_list_int32([1,-2,3]), fn x, acc -> acc * x end ) == -6
    assert Enum.reduce(Array.from_list_int64([1,-2,3]), fn x, acc -> acc * x end ) == -6
    assert Enum.reduce(Array.from_list_float32([1.0,-2.0,3.0]), fn x, acc -> acc * x end ) == -6.0
    assert Enum.reduce(Array.from_list_float64([1.0,-2.0,3.0]), fn x, acc -> acc * x end ) == -6.0
  end
end
