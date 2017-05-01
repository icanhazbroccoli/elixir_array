defmodule Array.Base do
  defmacro __using__([type: type, b_size: b_size]) when is_atom(type) and is_integer(b_size) do
    func_v_to_b    = "v_to_b_#{type}"    |> String.to_atom
    func_b_to_v    = "b_to_v_#{type}"    |> String.to_atom
    is_valid_guard = "is_valid_#{type}"  |> String.to_atom
    func_from_list = "from_list_#{type}" |> String.to_atom

    res = quote do

      def new(unquote(type), capacity) do
        body_size = capacity * unquote(b_size)
        %Array{ t: unquote(type), c: capacity, b: << 0 :: size( body_size ) >> }
      end

      def set(arr=%Array{t: unquote(type), c: capacity, b: body}, pos, val) when pos >= 0 and pos < capacity and unquote(is_valid_guard)(val) do
        pre_size = unquote(b_size) * pos
        v_size = unquote(b_size)
        rest_size = capacity * unquote(b_size) - pre_size - v_size
        b_val = unquote(func_v_to_b)(val)
        << pre :: size(pre_size), _ :: size(v_size), rest :: size(rest_size) >> = body
        %{arr | b: << pre :: size(pre_size), b_val :: bitstring, rest :: size(rest_size) >>}
      end

      def get(arr=%Array{t: unquote(type), c: capacity, b: body}, pos) when pos >= 0 and pos < capacity do
        pre_size = unquote(b_size) * pos
        v_size = unquote(b_size)
        << _ :: size(pre_size), b_val :: size(v_size), _ :: bitstring >> = body
        unquote(func_b_to_v)(<<b_val::size(v_size)>>)
      end

      # def from_list_#{type}
      def unquote(func_from_list)(list) do
        bit_chunks = list |> Enum.map(fn x ->
          case unquote(is_valid_guard)(x) do
            true -> << unquote(func_v_to_b)(x) :: bitstring >>
            _ -> raise "`#{x}` is not a valid #{unquote(type)} type"
          end
        end)
        %{Array.new(unquote(type), length(list)) | b: bit_chunks |> Enum.reduce(<<>>, fn(x, acc) -> <<acc::bitstring, x :: bitstring>> end)}
      end

      def to_list(arr=%Array{t: unquote(type), c: capacity, b: body}) do
        for ix <- 0..(capacity-1) do
          Array.get(arr, ix)
        end
      end

    end
    if System.get_env("EXPLAIN_MACRO") do
      IO.puts Macro.to_string(res)
    end
    res
  end
end
