alias Oasis.Antipattern, as: Antipattern
alias Oasis.Antipattern.SequentialID, as: SequentialID

defmodule SequentialIDTest do
  use ExUnit.Case, async: true

  test "detect/1: returns [%Antipattern{}] when a sequential ID is being used" do
    yaml_path = "test/fixtures/ecommerce.yml"
    yaml = YamlElixir.read_from_file!(yaml_path)

    expected_result = [
      %Antipattern{
        offender: "paths./orders/{order_id}/items/{item_id}?order_id",
        type: :sequential_id
      },
      %Antipattern{
        offender: "paths./orders/{order_id}/items/{item_id}?item_id",
        type: :sequential_id
      }
    ]

    result = SequentialID.detect(yaml)

    assert(result == expected_result)
  end

  test "detect/1: returns [] when a sequential ID is not found" do
    yaml_path = "test/fixtures/no_antipatterns.yml"
    yaml = YamlElixir.read_from_file!(yaml_path)

    expected_result = []

    result = SequentialID.detect(yaml)

    assert(result == expected_result)
  end
end
