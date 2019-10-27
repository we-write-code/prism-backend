defmodule Prism.Repo do
  use Ecto.Repo,
    otp_app: :prism,
    adapter: Ecto.Adapters.Postgres
end
