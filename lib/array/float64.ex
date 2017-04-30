defmodule Array.Float64 do
  defmacro __using__(_opts) do
    quote do
      def v_to_b_float64(val), do: << val :: signed-float-size(64) >>
      def b_to_v_float64(<< v :: signed-float-size(64) >>), do: v
      defmacro is_valid_float64(val) do
        quote do
          is_float(unquote(val))
        end
      end
      use Array.Base, type: :float64, b_size: 64
    end
  end

  defmodule Sigils do
    def sigil_d(list, _opts) do
      list |> String.split |> Enum.map(&String.to_float/1) |> Array.from_list_float64
    end
  end
end
