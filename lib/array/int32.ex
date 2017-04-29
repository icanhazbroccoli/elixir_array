defmodule Array.Int32 do
  defmacro __using__(_opts) do
    quote do
      def v_to_b_int32(val), do: << val :: 32 >>
      def b_to_v_int32(<<v::signed-integer-size(32)>>), do: v
      defmacro is_valid_int32(val) do
        quote do
          is_integer(unquote(val)) and unquote(val) >= -2147483648 and unquote(val) <= 2147483647
        end
      end
      use Array.Base, type: :int32, b_size: 32
    end
  end
end
