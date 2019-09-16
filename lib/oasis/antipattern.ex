alias Oasis.Antipattern, as: Antipattern

defmodule Oasis.Antipattern do
  @enforce_keys [:offender, :type]
  defstruct [:offender, :type]

  def detect_all(yaml) do
    [deep_paths(yaml), sequential_id(yaml)]
    |> List.flatten()
  end

  defp deep_paths(yaml) do
    yaml["paths"]
    |> Map.keys()
    |> Enum.map(fn path ->
      if String.match?(path, ~r/\{.+\}.+\{.+\}/) do
        %Antipattern{offender: "paths.#{path}", type: :deep_path}
      end
    end)
    |> Enum.filter(& &1)
  end

  defp sequential_id(yaml) do
    yaml["paths"]
    |> Map.keys()
    |> Enum.map(fn path ->
      path_metadata = yaml["paths"][path]
      get_metadata = path_metadata["get"]

      if get_metadata do
        relevant_params =
          Regex.scan(~r/\{((?:[a-z]|[0-9]|[_-])+)\}/i, path)
          |> List.flatten()
          |> Enum.reject(fn match -> String.starts_with?(match, "{") end)
          |> Enum.filter(fn param ->
            String.match?(param, ~r/(?:.+[_-]*[iI](?:d|D|dentifier))$/)
          end)

        (get_metadata["parameters"] ||
           [])
        |> Enum.filter(fn param_metadata ->
          Enum.member?(relevant_params, param_metadata["name"])
        end)
        |> Enum.map(fn param_metadata ->
          if (param_metadata["schema"] || %{})["type"] == "integer" do
            %Antipattern{
              offender: "paths.#{path}?#{param_metadata["name"]}",
              type: :sequential_id
            }
          end
        end)
      end
    end)
    |> List.flatten()
    |> Enum.filter(& &1)
  end
end
