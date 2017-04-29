defmodule ArrayBaseTest do

  use ExUnit.Case
  doctest Array.Base

  defmodule ArrayTest do
    def v_to_b_test(v), do: <<v::32>>
    def b_to_v_test(<<v>>), do: v
    use Array.Base, type: :test, b_size: 42
  end

  test "generates a constructor function" do
    assert ArrayTest.new(:test, 10) == { :array, :test, 10, << 0 :: size(420) >> }
  end

end
