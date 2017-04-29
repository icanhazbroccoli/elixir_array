defmodule Array.Base do
  defmacro __using__([type: type, b_size: b_size]) when is_atom(type) and is_integer(b_size) do
    func_v_to_b = "v_to_b_#{type}" |> String.to_atom
    quote do

      def new(unquote(type), capacity) do
        body_size = capacity * unquote(b_size)
        { :array, unquote(type), capacity, << 0 :: size( body_size ) >> }
      end

      def set(arr={ :array, unquote(type), capacity, body }, pos, val) when pos >= 0 and pos < capacity do
        pre_size = unquote(b_size) * pos
        v_size = unquote(b_size)
        rest_size = capacity * unquote(b_size) - pre_size - v_size
        b_val = unquote(func_v_to_b)(val)
        << pre :: size(pre_size), _ :: size(v_size), rest :: size(rest_size) >> = body
        :erlang.setelement(4, arr, << pre :: size(pre_size), b_val :: bitstring, rest :: size(rest_size) >>)
      end

    end
  end
end
