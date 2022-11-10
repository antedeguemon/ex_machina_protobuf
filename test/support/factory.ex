defmodule ExMachinaProtobuf.Factory do
  use ExMachina.ProtobufStrategy

  alias ExMachinaProtobuf.Protobufs.Person

  def person_factory do
    Person.new!(
      age: 26,
      name: Enum.random(["João", "José", "Maria", "Paula"]),
      cities: ["Porto Alegre", "São Paulo", "Toronto"]
    )
  end
end
