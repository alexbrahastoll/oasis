alias Oasis.Antipattern, as: Antipattern

defmodule Oasis.Parser do
  def parse(yaml_path) do
    case YamlElixir.read_from_file(yaml_path) do
      {:ok, yaml} ->
        Antipattern.detect_all(yaml)
        {:ok, "Successfully read #{yaml_path}"}

      _ ->
        {:error, nil}
    end
  end
end
