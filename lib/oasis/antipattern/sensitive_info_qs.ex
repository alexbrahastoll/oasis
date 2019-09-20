alias Oasis.Antipattern, as: Antipattern
alias Oasis.Antipattern.Util, as: Util

defmodule Oasis.Antipattern.SensitiveInfoQS do
  @offense_type :sensitive_info_qs
  @sensitive_names_list ["secret", "password", "pwd", "token", "session"]

  def detect(yaml) do
    yaml
    |> Util.filter_get_paths()
    |> detect_sensitive_info
    |> List.flatten()
    |> Enum.filter(& &1)
  end

  defp detect_sensitive_info(get_paths) do
    get_paths
    |> Enum.map(fn {path, metadata} ->
      params = metadata["get"]["parameters"] || []

      params
      |> Enum.filter(fn param_metadata ->
        Enum.member?(sensitive_info_params(path), param_metadata["name"])
      end)
      |> Enum.map(fn param_metadata ->
        %Antipattern{
          offender: "paths.#{path}?#{param_metadata["name"]}",
          type: @offense_type
        }
      end)
    end)
  end

  defp sensitive_info_params(path) do
    path
    |> Util.extract_params_from_path()
    |> Enum.filter(fn param ->
      Enum.any?(@sensitive_names_list, fn name ->
        String.contains?(param, name)
      end)
    end)
  end
end
