defmodule ArrayInt16Test do

  use ExUnit.Case
  doctest Array.Int16

  defmodule ArrayTest do
    use Array.Int16
  end

  test "v_to_b" do
    assert ArrayTest.v_to_b_int16(0) == <<0::16>>
    assert ArrayTest.v_to_b_int16(32767) == <<127,255>>
    assert ArrayTest.v_to_b_int16(1) == <<1::16>>
    assert ArrayTest.v_to_b_int16(-32768) == <<128,0>>
    assert ArrayTest.v_to_b_int16(-1) == <<255,255>>
  end

end
