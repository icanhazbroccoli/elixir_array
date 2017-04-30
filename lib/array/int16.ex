defmodule Array.Int16 do
  defmacro __using__(_opts) do
    quote do
      def v_to_b_int16(val), do: << val :: signed-integer-size(16) >>
      def b_to_v_int16(<<v::signed-integer-size(16)>>), do: v
      defmacro is_valid_int16(val) do
        quote do
          is_integer(unquote(val)) and unquote(val) >= -32768 and unquote(val) <= 32767
        end
      end
      use Array.Base, type: :int16, b_size: 16
    end
  end

  defmodule Sigils do
    def sigil_h(list, _opts) do
      list |> String.split |> Enum.map(&String.to_integer/1) |> Array.from_list_int16
    end
  end
end
