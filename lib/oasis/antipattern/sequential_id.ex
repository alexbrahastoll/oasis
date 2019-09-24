alias Oasis.Antipattern
alias Oasis.Antipattern.Util

defmodule Oasis.Antipattern.SequentialID do
  def detect(yaml) do
    yaml
    |> Util.filter_get_paths()
    |> detect_sequential_id_params
    |> List.flatten()
    |> Enum.filter(& &1)
  end

  defp detect_sequential_id_params(get_paths) do
    get_paths
    |> Enum.map(fn {path, metadata} ->
      params = metadata["get"]["parameters"] || []

      params
      |> Enum.filter(fn param_metadata ->
        Enum.member?(path_id_params(path), param_metadata["name"])
      end)
      |> Enum.map(fn param_metadata ->
        if (param_metadata["schema"] || %{})["type"] == "integer" do
          %Antipattern{
            offender: "paths.#{path}?#{param_metadata["name"]}",
            type: :sequential_id
          }
        end
      end)
    end)
  end

  defp path_id_params(path) do
    path
    |> Util.extract_params_from_path()
    |> Enum.filter(fn param ->
      String.match?(param, ~r/(?:.+[_-]*[iI](?:d|D|dentifier))$/)
    end)
  end
end
