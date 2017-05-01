defmodule Array.Enumerable do

  defimpl Enumerable, for: Array do

    def count(%Array{c: capacity}) do
      {:ok, capacity}
    end

    def member?(arr=%Array{c: capacity}, el) do
      {:ok, Enum.find(0..(capacity-1), fn ix ->
        Array.get(arr, ix) == el
      end) == nil}
    end

    def reduce(_, {:halt, acc}, _fun), do: {:halted, acc}
    def reduce({arr=%Array{}, ix, b_size}, {:suspend, acc}, fun), do: {:suspended, acc, &reduce({arr, ix, b_size}, &1, fun)}
    def reduce({%Array{b: <<>>}, _, _}, {:cont, acc}, _fun), do: {:done, acc}
    def reduce(%Array{b: <<>>}, {:cont, acc}, _fun), do: {:done, acc}
    def reduce({%Array{c: capacity}, ix}, {:cont, acc}, _fun) when is_integer(ix) and ix >= capacity do
      {:done, acc}
    end
    def reduce({arr=%Array{}, ix}, {:cont, acc}, fun) when is_integer(ix) do
      reduce({arr, ix + 1}, fun.(Array.get(arr, ix), acc), fun)
    end
    def reduce(arr=%Array{}, {:cont, acc}, fun) do
      reduce({arr, 0}, {:cont, acc}, fun)
    end
    
  end

end
