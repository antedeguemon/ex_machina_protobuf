defmodule ExMachina.ProtobufStrategy do
  @moduledoc """
  ExMachina strategy for creating Protobuf factories in a safer way.

  Structs built using the `ExMachina.ProtobufStrategy` strategy are passed into
  Protobuf's encode and decode pipeline, which assures messages can be properly
  both encoded and decoded.

  This assurance helps bring factories closer to real-life scenarios, as
  unencodable / undecodable Protobuf messages cannot be sent over the network.

  Note that factory functions should always return a Protobuf struct.

  ## Factory definition Example

    ```
    defmodule MyProject.Factory do
      use ExMachina.ProtobufStrategy

      alias CompiledProtobufs.Car
      alias Google.Protobuf.Timestamp

      # For factories returns, it doesn't matter if they are built `new/1`,
      # `new!/1` or directly defined as a struct with `%{}`.
      # The only requirement is that factories should return Protobuf structs.
      def car_factory do
        Car.new!(
          maker: Enum.random(["Ford", "Hyundai", "Toyota"]),
          year: Enum.random(2015..2023)
        )
      end

      def bool_value_factory do
        %Google.Protobuf.BoolValue{
          value: Enum.random([true, false])
        }
      end
    end
    ```
  """

  use ExMachina.Strategy, function_name: :build_protobuf

  def handle_build_protobuf(%module{} = message, _opts) do
    if not function_exported?(module, :__message_props__, 0) do
      raise "Protobuf strategy error: #{module} is not a Protobuf module"
    end

    message
    |> module.encode()
    |> module.decode()
  end
end
