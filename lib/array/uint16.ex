defmodule Array.UInt16 do
  defmacro __using__(_opts) do
    quote do
      def v_to_b_uint16(val), do: << val :: 16 >>
      def b_to_v_uint16(<<v::unsigned-integer-size(16)>>), do: v
      defmacro is_valid_uint16(val) do
        quote do
          is_integer(unquote(val)) and unquote(val) >= 0 and unquote(val) <= 65536
        end
      end
      use Array.Base, type: :uint16, b_size: 16
    end
  end
end
