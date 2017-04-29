defmodule Array.UInt64 do
  defmacro __using__(_opts) do
    quote do
      def v_to_b_uint64(val), do: << val :: 64 >>
      def b_to_v_uint64(<<v::unsigned-integer-size(64)>>), do: v
      defmacro is_valid_uint64(val) do
        quote do
          is_integer(unquote(val)) and unquote(val) >= 0 and unquote(val) <= 18446744073709551616
        end
      end
      use Array.Base, type: :uint64, b_size: 64
    end
  end
end
