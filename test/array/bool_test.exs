defmodule ArrayBoolTest do

  use ExUnit.Case
  doctest Array.Boolean

  defmodule ArrayTest do
    use Array.Boolean
  end

  test "v_to_b" do
    assert ArrayTest.v_to_b_bool(true)  == <<1::1>>
    assert ArrayTest.v_to_b_bool(false) == <<0::1>>
  end

  test "b_to_v" do
    assert ArrayTest.b_to_v_bool(<<1::1>>) == true
    assert ArrayTest.b_to_v_bool(<<0::1>>) == false
  end

  test "new" do
    assert ArrayTest.new(:bool, 5) == {:array, :bool, 5, <<0::5>>}
  end

  test "set one by one independently" do
    arr = ArrayTest.new(:bool, 5)
    assert ArrayTest.set(arr, 0, true) == {:array, :bool, 5, <<1::1, 0::4>>}
    assert ArrayTest.set(arr, 1, true) == {:array, :bool, 5, <<0::1, 1::1, 0::3>>}
    assert ArrayTest.set(arr, 2, true) == {:array, :bool, 5, <<0::2, 1::1, 0::2>>}
    assert ArrayTest.set(arr, 3, true) == {:array, :bool, 5, <<0::3, 1::1, 0::1>>}
    assert ArrayTest.set(arr, 4, true) == {:array, :bool, 5, <<0::4, 1::1>>}
  end

  test "update one by one" do
    arr = ArrayTest.new(:bool, 5)
    ar1 = ArrayTest.set(arr, 0, true)
    ar2 = ArrayTest.set(ar1, 1, true)
    ar3 = ArrayTest.set(ar2, 2, true)
    ar4 = ArrayTest.set(ar3, 3, true)
    ar5 = ArrayTest.set(ar4, 4, true)
    assert ar1 == {:array, :bool, 5, <<1::1, 0::4>>}
    assert ar2 == {:array, :bool, 5, <<1::1, 1::1, 0::3>>}
    assert ar3 == {:array, :bool, 5, <<1::1, 1::1, 1::1, 0::2>>}
    assert ar4 == {:array, :bool, 5, <<1::1, 1::1, 1::1, 1::1, 0::1>>}
    assert ar5 == {:array, :bool, 5, <<1::1, 1::1, 1::1, 1::1, 1::1>>}
  end

  test "get val" do
    arr = ArrayTest.new(:bool, 3)
    0..2 |> Enum.each(fn ix ->
      assert ArrayTest.get(arr, ix) == false
    end)
    ar1 = ArrayTest.set(arr, 0, true)
    assert ArrayTest.get(ar1, 0) == true
    assert ArrayTest.get(ar1, 1) == false
    assert ArrayTest.get(ar1, 2) == false
    ar2 = ArrayTest.set(arr, 1, true)
    assert ArrayTest.get(ar2, 0) == false
    assert ArrayTest.get(ar2, 1) == true
    assert ArrayTest.get(ar2, 2) == false
    ar3 = ArrayTest.set(arr, 2, true)
    assert ArrayTest.get(ar3, 0) == false
    assert ArrayTest.get(ar3, 1) == false
    assert ArrayTest.get(ar3, 2) == true
  end

end
