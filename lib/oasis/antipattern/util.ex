defmodule Oasis.Antipattern.Util do
  def filter_get_paths(yaml) do
    yaml["paths"]
    |> Enum.filter(fn {_path, metadata} ->
      metadata["get"] != nil
    end)
  end

  def extract_params_from_path(path) do
    Regex.scan(~r/\{((?:[a-z]|[0-9]|[_-])+)\}/i, path)
    |> List.flatten()
    |> Enum.reject(fn match -> String.starts_with?(match, "{") end)
  end
end
