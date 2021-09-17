# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :ex_github,
  ecto_repos: [ExGithub.Repo]

# Configures the endpoint
config :ex_github, ExGithubWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "1xXmw+CGBjqChn1N94JItjqpkzWyJJo/4i0CJSxtH8RSeJZVU+zoB0lmSXr1BQZ7",
  render_errors: [view: ExGithubWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: ExGithub.PubSub,
  live_view: [signing_salt: "Ia2Mb/VG"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :ex_github, ExGithub.Repositories, api_client_adapter: ExGithub.Api.Client

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
