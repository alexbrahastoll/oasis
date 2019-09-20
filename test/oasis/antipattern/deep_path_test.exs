alias Oasis.Antipattern, as: Antipattern
alias Oasis.Antipattern.DeepPath, as: DeepPath

defmodule DeepPathTest do
  use ExUnit.Case, async: true

  test "detect/1: returns [%Antipattern{}] when a deep path is found" do
    yaml_path = "test/fixtures/ecommerce.yml"
    yaml = YamlElixir.read_from_file!(yaml_path)

    expected_result = [
      %Antipattern{
        offender: "paths./orders/{order_id}/items/{item_id}",
        type: :deep_path
      }
    ]

    result = DeepPath.detect(yaml)

    assert(result == expected_result)
  end

  test "detect/1: returns [] when no deep path is found" do
    yaml_path = "test/fixtures/no_antipatterns.yml"
    yaml = YamlElixir.read_from_file!(yaml_path)

    expected_result = []

    result = DeepPath.detect(yaml)

    assert(result == expected_result)
  end
end
