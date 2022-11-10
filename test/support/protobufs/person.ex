defmodule ExMachinaProtobuf.Protobufs.Person do
  @moduledoc false
  use Protobuf, syntax: :proto3

  field(:name, 1, type: :string)
  field(:age, 2, type: :int32)
  field(:cities, 3, repeated: true, type: :string)
end
