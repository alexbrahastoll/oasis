alias Oasis.Antipattern

defmodule Oasis.Antipattern.DeepPath do
  def detect(yaml) do
    yaml["paths"]
    |> Map.keys()
    |> Enum.map(fn path ->
      if String.match?(path, ~r/\{.+\}.+\{.+\}/) do
        %Antipattern{offender: "paths.#{path}", type: :deep_path}
      end
    end)
    |> Enum.filter(& &1)
  end
end
