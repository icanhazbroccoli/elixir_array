defmodule Array.Float32 do
  defmacro __using__(_opts) do
    quote do
      def v_to_b_float32(val), do: << val :: signed-float-size(32) >>
      def b_to_v_float32(<<v::signed-float-size(32)>>), do: v
      defmacro is_valid_float32(val) do
        quote do
          is_float(unquote(val))
        end
      end
      use Array.Base, type: :float32, b_size: 32
    end
  end

  defmodule Sigils do
    def sigil_f(list, _opts) do
      list |> String.split |> Enum.map(&String.to_float/1) |> Array.from_list_float32
    end
  end
end
