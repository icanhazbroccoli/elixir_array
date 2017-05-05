# Array

An Elixir implementation of statically typed fixed-size arrays.
This implementation provides O(N) space complexity, O(1) index-access time complexity and O(1) length time complexity. Enumerable extension provides O(N) membership check time complexity and O(N) map/reduce.

Supported data types:
  * boolean
  * int16
  * uint16
  * int32
  * uint32
  * float32
  * int64
  * uint64
  * float64

## API

#### Generic init API
The easiest way to init an array is to import it from an existing list. Import functions are type-specific:
```
Array.from_list_bool([true, true, false]) # Returns: %Array{b: <<6::size(3)>>, c: 3, t: :bool}
Array.from_list_float32([0.0, 1.5]) # Returns: %Array{b: <<0, 0, 0, 0, 63, 192, 0, 0>>, c: 2, t: :float32}
```

The full list of initializers:
  * Array.from_list_bool/1
  * Array.from_list_int16/1
  * Array.from_list_uint16/1
  * Array.from_list_int32/1
  * Array.from_list_uint32/1
  * Array.from_list_float32/1
  * Array.from_list_int64/1
  * Array.from_list_uint64/1
  * Array.from_list_float64/1

The setter functions above are sensitive to the data provided in the source-lists. E.g. Array.from_list_bool([1]) or Array.from_list_float32([1]) will throw an exception (Vs Array.from_list_bool([true]) and Array.from_list_float32([1.0]) are the correct ways to init the arrays).

#### Low-level init API

An array might be initialized usqing a low-level constructor function. It takes an array type and it's size: Array.new(type, capacity). This constructor initializes an empty array (all bits would be set to 0). One should expect 0 (casted to a corresponded type) values to be returned by Array.get/2 if no modifications were made inbetween. E.g.:

```
array_b = Array.new(:bool, 1)
assert Array.get(array_b, 0) == false

array_ui16 = Array.new(:uint16, 1)
assert Array.get(array_ui16, 0) == 0

array_f64 = Array.new(:float64, 1)
assert Array.get(array_f64, 0) == 0.0
```

#### Setter API

Updating an element of an array is very straightforward:

```
array = Array.new(:int32, 3)
element_ix = 1
element_val = 42
new_array = Array.set(array, element_ix, ekement_val)
```

#### Getter API

Getting an element of an array:

```
array = Array.new(:int32, 3) |> Array.set(1, 42) # does the same as an example above
assert Array.get(array, 0) == 0
assert Array.get(array, 1) == 42
assert Array.get(array, 2) == 0
```

#### Export API

Array can be converted back to a list easilly:

```
array = Array.new(:int64, 1) |> Array.set(0, 42)
assert Array.to_list(array) == [42]
```

Exporting to list has O(N) time complexity.

#### Sigils

There is some init syntax sugar for Array which uses sigils.

Sigil table:

| Sigil | Type    | Init API Equivalent     |
|-------|---------|-------------------------|
|    ~b | bool    | Array.from_list_bool    |
|    ~h | int16   | Array.from_list_int16   |
|    ~i | int32   | Array.from_list_int32   |
|    ~l | int64   | Array.from_list_int64   |
|    ~o | uint16  | Array.from_list_uint16  |
|    ~u | uint32  | Array.from_list_uint32  |
|    ~x | uint64  | Array.from_list_uint64  |
|    ~f | float32 | Array.from_list_float32 |
|    ~d | float64 | Array.from_list_float64 |

Sigils are handy shortcuts for array initialization but are not as verbose and explicit as their elder brothers Array.new and Array.from_list_<type>.
