Bureaucrat.start(
    default_path: "../DOCUMENTATION.md",
    json_library: Jason
)
ExUnit.start(formatters: [ExUnit.CLIFormatter, Bureaucrat.Formatter])
# Ecto.Adapters.SQL.Sandbox.mode(Prism.Repo, :manual)
