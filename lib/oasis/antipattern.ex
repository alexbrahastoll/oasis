alias Oasis.Antipattern.DeepPath, as: DeepPath
alias Oasis.Antipattern.SequentialID, as: SequentialID
alias Oasis.Antipattern.SensitiveInfoQS, as: SensitiveInfoQS

defmodule Oasis.Antipattern do
  @enforce_keys [:offender, :type]
  defstruct [:offender, :type]

  def detect_all(yaml) do
    [DeepPath.detect(yaml), SequentialID.detect(yaml), SensitiveInfoQS.detect(yaml)]
    |> List.flatten()
  end
end
