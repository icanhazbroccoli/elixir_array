defmodule ArraySigilsTest do

  use ExUnit.Case
  doctest Array.Sigils
  use Array.Sigils

  test "sigil_bool" do
    assert ~b(true true false) == %Array{t: :bool, c: 3, b: <<1::1, 1::1, 0::1>>}
    assert ~b() == %Array{t: :bool, c: 0, b: <<>>}
    assert Array.get(~b(false true false), 1) == true
    check = try do
      ~b(true true 1)
    rescue
      RuntimeError -> true
    end
    assert check == true
  end

  test "sigil_int16" do
    arr = ~h(1 2 3 -32768 32767)
    assert arr == %Array{t: :int16, c: 5, b: <<0, 1, 0, 2, 0, 3, 128, 0, 127, 255>>}
    assert Array.get(arr, 0) == 1
    assert Array.get(arr, 1) == 2
    assert Array.get(arr, 2) == 3
    assert Array.get(arr, 3) == -32768
    assert Array.get(arr, 4) == 32767

    assert ~h() == %Array{t: :int16, c: 0, b: <<>>}
    check = try do
      ~h(1 2 32768)
    rescue
      RuntimeError -> true
    end
    assert check == true
  end

  test "sigil_int32" do
    arr = ~i(1 2 3 -2147483648 2147483647)
    assert arr == %Array{t: :int32, c: 5, b: <<0, 0, 0, 1, 0, 0, 0, 2, 0, 0, 0, 3, 128, 0, 0, 0, 127, 255, 255, 255>>}
    assert Array.get(arr, 0) == 1
    assert Array.get(arr, 1) == 2
    assert Array.get(arr, 2) == 3
    assert Array.get(arr, 3) == -2147483648
    assert Array.get(arr, 4) == 2147483647
    assert ~i() == %Array{t: :int32, c: 0, b: <<>>}
    check = try do
      ~i(1 2 3 a b)
    rescue
      RuntimeError  -> true
      ArgumentError -> true
    end
    assert check == true
  end

  test "sigil_int64" do
    arr = ~l(1 2 3 -9223372036854775808 9223372036854775807)
    assert arr == %Array{t: :int64, c: 5, b: <<0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 3, 128, 0, 0, 0, 0, 0, 0, 0, 127, 255, 255, 255, 255, 255, 255, 255>>}
    assert Array.get(arr, 0) == 1
    assert Array.get(arr, 1) == 2
    assert Array.get(arr, 2) == 3
    assert Array.get(arr, 3) == -9223372036854775808
    assert Array.get(arr, 4) == 9223372036854775807
    assert ~l() == %Array{t: :int64, c: 0, b: <<>>}
    check = try do
      ~l(1 2 3 a b)
    rescue
      RuntimeError  -> true
      ArgumentError -> true
    end
    assert check == true
  end

  test "sigil_uint16" do
    arr = ~o(1 2 3 0 65535)
    assert arr == %Array{t: :uint16, c: 5, b: <<0, 1, 0, 2, 0, 3, 0, 0, 255, 255>>}
    assert Array.get(arr, 0) == 1
    assert Array.get(arr, 1) == 2
    assert Array.get(arr, 2) == 3
    assert Array.get(arr, 3) == 0
    assert Array.get(arr, 4) == 65535

    assert ~o() == %Array{t: :uint16, c: 0, b: <<>>}
    check = try do
      ~o(1 2 a b c)
    rescue
      RuntimeError -> true
      ArgumentError -> true
    end
    assert check == true
  end

  test "sigil_uint32" do
    arr = ~u(1 2 3 0 4294967295)
    assert arr == %Array{t: :uint32, c: 5, b: <<0, 0, 0, 1, 0, 0, 0, 2, 0, 0, 0, 3, 0, 0, 0, 0, 255, 255, 255, 255>>}
    assert Array.get(arr, 0) == 1
    assert Array.get(arr, 1) == 2
    assert Array.get(arr, 2) == 3
    assert Array.get(arr, 3) == 0
    assert Array.get(arr, 4) == 4294967295

    assert ~u() == %Array{t: :uint32, c: 0, b: <<>>}
    check = try do
      ~u(1 2 a b c)
    rescue
      RuntimeError -> true
      ArgumentError -> true
    end
    assert check == true
  end

  test "sigil_uint64" do
    arr = ~x(1 2 3 0 18446744073709551615)
    assert arr == %Array{t: :uint64, c: 5, b: <<0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 255, 255, 255, 255, 255, 255, 255, 255>>}
    assert Array.get(arr, 0) == 1
    assert Array.get(arr, 1) == 2
    assert Array.get(arr, 2) == 3
    assert Array.get(arr, 3) == 0
    assert Array.get(arr, 4) == 18446744073709551615

    assert ~x() == %Array{t: :uint64, c: 0, b: <<>>}
    check = try do
      ~x(1 2 a b c)
    rescue
      RuntimeError -> true
      ArgumentError -> true
    end
    assert check == true
  end

  test "sigil_float32" do
    arr = ~f(1.0 2.0 3.0 0.1 -1.0)
    assert arr == %Array{t: :float32, c: 5, b: <<63, 128, 0, 0, 64, 0, 0, 0, 64, 64, 0, 0, 61, 204, 204, 205, 191, 128, 0, 0>>}
    assert Array.get(arr, 0) == 1.0
    assert Array.get(arr, 1) == 2.0
    assert Array.get(arr, 2) == 3.0
    assert Array.get(arr, 3) |> Float.round(1) == 0.1
    assert Array.get(arr, 4) == -1.0

    assert ~f() == %Array{t: :float32, c: 0, b: <<>>}
    check = try do
      ~f(1.0 .2 a b c)
    rescue
      RuntimeError -> true
      ArgumentError -> true
    end
    assert check == true
  end

  test "sigil_float64" do
    arr = ~d(1.0 2.0 3.0 0.1 -1.0)
    assert arr == %Array{t: :float64, c: 5, b: <<63, 240, 0, 0, 0, 0, 0, 0, 64, 0, 0, 0, 0, 0, 0, 0, 64, 8, 0, 0, 0, 0, 0, 0, 63, 185, 153, 153, 153, 153, 153, 154, 191, 240, 0, 0, 0, 0, 0, 0>>}
    assert Array.get(arr, 0) == 1.0
    assert Array.get(arr, 1) == 2.0
    assert Array.get(arr, 2) == 3.0
    assert Array.get(arr, 3) |> Float.round(1) == 0.1
    assert Array.get(arr, 4) == -1.0

    assert ~d() == %Array{t: :float64, c: 0, b: <<>>}
    check = try do
      ~d(1.0 2.0 a)
    rescue
      RuntimeError -> true
      ArgumentError -> true
    end
    assert check == true
  end
end
