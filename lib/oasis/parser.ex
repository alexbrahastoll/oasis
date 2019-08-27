alias Oasis.Antipattern, as: Antipattern

defmodule Oasis.Parser do
  def parse(yaml_path) do
    case YamlElixir.read_from_file(yaml_path) do
      {:ok, yaml} ->
        {:ok,
         Antipattern.detect_all(yaml)
         |> Reporter.generate_report()}

      _ ->
        {:error, nil}
    end
  end
end
