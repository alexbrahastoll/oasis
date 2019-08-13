alias Oasis.Antipattern, as: Antipattern

defmodule Oasis.Antipattern do
  @enforce_keys [:violator, :type]
  defstruct [:violator, :type]

  def detect_all(yaml) do
    deep_paths(yaml)
  end

  defp deep_paths(yaml) do
    yaml["paths"]
    |> Map.keys()
    |> Enum.map(fn path ->
      if String.match?(path, ~r/\{.+\}.+\{.+\}/) do
        %Antipattern{violator: "paths.#{path}", type: :deep_path}
      end
    end)
    |> Enum.filter(& &1)
  end
end
