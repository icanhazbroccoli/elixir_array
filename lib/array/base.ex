defmodule Array.Base do
  defmacro __using__([type: type, b_size: b_size]) when is_atom(type) and is_integer(b_size) do
    func_v_to_b = "v_to_b_#{type}" |> String.to_atom
    func_b_to_v = "b_to_v_#{type}" |> String.to_atom
    is_valid_guard = "is_valid_#{type}" |> String.to_atom
    res = quote do

      def new(unquote(type), capacity) do
        body_size = capacity * unquote(b_size)
        { :array, unquote(type), capacity, << 0 :: size( body_size ) >> }
      end

      def set(arr={:array, unquote(type), capacity, body}, pos, val) when pos >= 0 and pos < capacity and unquote(is_valid_guard)(val) do
        pre_size = unquote(b_size) * pos
        v_size = unquote(b_size)
        rest_size = capacity * unquote(b_size) - pre_size - v_size
        b_val = unquote(func_v_to_b)(val)
        << pre :: size(pre_size), _ :: size(v_size), rest :: size(rest_size) >> = body
        :erlang.setelement(4, arr, << pre :: size(pre_size), b_val :: bitstring, rest :: size(rest_size) >>)
      end

      def get(arr={:array, unquote(type), capacity, body}, pos) when pos >= 0 and pos < capacity do
        pre_size = unquote(b_size) * pos
        v_size = unquote(b_size)
        << _ :: size(pre_size), b_val :: size(v_size), _ :: bitstring >> = body
        unquote(func_b_to_v)(<<b_val::size(v_size)>>)
      end

    end
    if System.get_env("EXPLAIN_MACRO") do
      IO.puts Macro.to_string(res)
    end
    res
  end
end
