defmodule ExMachina.ProtobufStrategyTest do
  use ExUnit.Case, async: true
  alias ExMachinaProtobuf.Protobufs.Person
  import ExMachinaProtobuf.Factory

  test "builds protobuf message from factory" do
    assert %Person{name: name, age: age, cities: [_ | _]} = build_protobuf(:person)
    assert is_binary(name)
    assert is_integer(age)
  end

  test "merges factory opts" do
    assert build_protobuf(:person, name: "Vicente", age: 26, cities: ["Porto Alegre"]) == %Person{
             name: "Vicente",
             age: 26,
             cities: ["Porto Alegre"]
           }
  end

  test "errors when field has invalid value" do
    assert_raise Protobuf.EncodeError,
                 ~r/Got error when encoding ExMachinaProtobuf.Protobufs.Person#age/,
                 fn ->
                   build_protobuf(:person, age: "not_integer")
                 end
  end
end
