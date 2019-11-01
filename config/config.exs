# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :prism,
  ecto_repos: [Prism.Repo]

# Configures the endpoint
config :prism, PrismWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "gDpbG0lKQ2tI6jZCWr5sb5HORifS3zza6vG66fbeCsc9mZx4jlkbc7eI9GTnii2k",
  render_errors: [view: PrismWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Prism.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Change Password hashing configuration to desireable values
# t_cost defines the number of iterations
# m_cost deifines the number of memory used in powers of 2 (KiB)
config :argon2_elixir, t_cost: 10, m_cost: 18

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
