alias Oasis.Antipattern
alias Oasis.Reporter

defmodule Oasis.Parser do
  def parse(yaml_path) do
    case YamlElixir.read_from_file(yaml_path) do
      {:ok, yaml} ->
        Antipattern.detect_all(yaml)
        |> Reporter.generate_report()

      _ ->
        {:error, nil}
    end
  end
end
