defmodule Array.Int64 do
  defmacro __using__(_opts) do
    quote do
      def v_to_b_int64(val), do: << val :: 64 >>
      def b_to_v_int64(<<v::signed-integer-size(64)>>), do: v
      defmacro is_valid_int64(val) do
        quote do
          is_integer(unquote(val)) and unquote(val) >= -9223372036854775808 and unquote(val) <= 9223372036854775807
        end
      end
      use Array.Base, type: :int64, b_size: 64
    end
  end

  defmodule Sigils do
    def sigil_l(list, _opts) do
      list |> String.split |> Enum.map(&String.to_integer/1) |> Array.from_list_int64
    end
  end
end
