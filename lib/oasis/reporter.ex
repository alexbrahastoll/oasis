defmodule Reporter do
  require EEx
  EEx.function_from_file(:def, :report, "templates/report.html.eex", [:antipatterns])

  def generate_report(antipatterns) do
    report_path = "output/report_#{System.system_time(:second)}.html"
    File.write!(report_path, report(antipatterns))
    "OpenAPI antipatterns detected. Report generated at #{report_path}"
  end
end
