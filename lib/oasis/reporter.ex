defmodule Oasis.Reporter do
  require EEx
  EEx.function_from_file(:def, :report, "templates/report.html.eex", [:antipatterns])

  def generate_report(antipatterns) when length(antipatterns) == 0 do
    {:no_antipatterns, nil}
  end

  def generate_report(antipatterns) when length(antipatterns) > 0 do
    report_path = "output/report_#{System.system_time(:second)}.html"
    File.write!(report_path, report(antipatterns))
    {:ok, report_path}
  end
end
