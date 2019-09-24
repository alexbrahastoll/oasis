alias Oasis.Reporter
alias Oasis.Antipattern

defmodule ReporterTest do
  use ExUnit.Case, async: true

  test "generate_report/1 returns {:no_antipatterns, nil} when given an empty list" do
    antipatterns = []

    result = Reporter.generate_report(antipatterns)

    assert(result == {:no_antipatterns, nil})
  end

  test "generate_report/1 returns {:ok, String} when given a list of Antipattern structs" do
    antipatterns = [
      %Antipattern{
        offender: "paths./path/{param_id}/path/{param_id}",
        type: :deep_path
      }
    ]

    {status, path} = Reporter.generate_report(antipatterns)

    assert(status == :ok)
    assert(String.starts_with?(path, "output/report_"))
  end
end
