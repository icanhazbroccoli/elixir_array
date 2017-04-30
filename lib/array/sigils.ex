defmodule Array.Sigils do
  defmacro __using__(_opts) do
    quote do
      import Array.Boolean.Sigils
      import Array.Int16.Sigils
      import Array.UInt16.Sigils
      import Array.Int32.Sigils
      import Array.UInt32.Sigils
      import Array.Float32.Sigils
      import Array.Int64.Sigils
      import Array.UInt64.Sigils
      import Array.Float64.Sigils
    end
  end
end
