alias Oasis.Antipattern, as: Antipattern
alias Oasis.Antipattern.SensitiveInfoQS, as: SensitiveInfoQS

defmodule SensitiveInfoQSTest do
  use ExUnit.Case, async: true

  test "detect/1: returns [%Antipattern{}] when a param in the query string seems to hold sensitive info" do
    yaml_path = "test/fixtures/ecommerce.yml"
    yaml = YamlElixir.read_from_file!(yaml_path)

    expected_result = [
      %Antipattern{
        offender: "paths./customers/{customer_token}?customer_token",
        type: :sensitive_info_qs
      }
    ]

    result = SensitiveInfoQS.detect(yaml)

    assert(result == expected_result)
  end

  test "detect/1: returns [] when no params seem to hold sensitive info" do
    yaml_path = "test/fixtures/no_antipatterns.yml"
    yaml = YamlElixir.read_from_file!(yaml_path)

    expected_result = []

    result = SensitiveInfoQS.detect(yaml)

    assert(result == expected_result)
  end
end
