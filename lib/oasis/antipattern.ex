alias Oasis.Antipattern, as: Antipattern
alias Oasis.Antipattern.SequentialID, as: SequentialID
alias Oasis.Antipattern.SensitiveInfoQS, as: SensitiveInfoQS

defmodule Oasis.Antipattern do
  @enforce_keys [:offender, :type]
  defstruct [:offender, :type]

  def detect_all(yaml) do
    [deep_paths(yaml), SequentialID.detect(yaml), SensitiveInfoQS.detect(yaml)]
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
end
