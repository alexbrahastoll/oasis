alias Oasis.Parser, as: Parser

defmodule Oasis.CLI do
  def main(cli_args) do
    case cli_args do
      [] ->
        IO.puts("oasis usage: oasis <open_api_spec_file_path>")

      [oas_path] ->
        case Parser.parse(oas_path) do
          {:ok, report} ->
            IO.puts(report)

          {:error, _} ->
            IO.puts("It was not possible to parse #{oas_path}.")
            IO.puts("Are you sure the file exists and is valid?")
        end
    end
  end
end
