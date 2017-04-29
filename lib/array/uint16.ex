defmodule Array.UInt16 do
  defmacro __using__(_opts) do
    quote do
      use Array.Base, type: :uint16, b_size: 16
    end
  end
end
