defmodule Array.Int16 do
  defmacro __using__(_opts) do
    quote do
      def v_to_b_int16(val),  do: << val :: 16 >>
      def b_to_v_int16(<<v::signed-integer-size(16)>>), do: v
      use Array.Base, type: :int16, b_size: 16
    end
  end
end
