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
end
