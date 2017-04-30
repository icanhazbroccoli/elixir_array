defmodule Array.UInt32 do
  defmacro __using__(_opts) do
    quote do
      def v_to_b_uint32(val), do: << val :: 32 >>
      def b_to_v_uint32(<<v::unsigned-integer-size(32)>>), do: v
      defmacro is_valid_uint32(val) do
        quote do
          is_integer(unquote(val)) and unquote(val) >= 0 and unquote(val) <= 4294967295
        end
      end
      use Array.Base, type: :uint32, b_size: 32
    end
  end

  defmodule Sigils do
    def sigil_u(list, _opts) do
      list |> String.split |> Enum.map(&String.to_integer/1) |> Array.from_list_uint32
    end
  end
end
