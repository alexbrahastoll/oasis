alias Oasis.Parser

defmodule Oasis.CLI do
  def main(cli_args) do
    case cli_args do
      [] ->
        IO.puts("oasis usage: oasis <open_api_spec_file_path>")

      [oas_path] ->
        case Parser.parse(oas_path) do
          {:ok, report_path} ->
            IO.puts("OpenAPI antipatterns detected. Report generated at #{report_path}")

          {:no_antipatterns, _} ->
            IO.puts("Hooray! No antipatterns were detected.")

          {:error, _} ->
            IO.puts("It was not possible to parse #{oas_path}.")
            IO.puts("Are you sure the file exists and is valid?")
        end
    end
  end
end
