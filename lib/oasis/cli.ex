defmodule Oasis.CLI do
  def main(cli_args) do
    case cli_args do
      [] ->
        IO.puts("oasis usage: oasis <open_api_spec_file_path>")

      [oas_path] ->
        IO.puts("Checking specification at #{oas_path}")
    end
  end
end
