defmodule Array.Boolean do
  defmacro __using__(_opts) do
    quote do
      def v_to_b_bool(true),  do: << 1 :: size(1) >>
      def v_to_b_bool(false), do: << 0 :: size(1) >>
      def b_to_v_bool(<<0::1>>), do: false
      def b_to_v_bool(<<1::1>>), do: true
      defmacro is_valid_bool(val) do
        quote do
          is_boolean(unquote(val))
        end
      end
      use Array.Base, type: :bool, b_size: 1
    end
  end

  defmodule Sigils do
    def sigil_b(list, _opts) do
      list |> String.split |> Enum.map(&string_to_bool/1) |> Array.from_list_bool
    end

    defp string_to_bool("true"),  do: true
    defp string_to_bool("false"), do: false
    defp string_to_bool(v), do: raise "#{v} is not a boolean value" 
  end
end
