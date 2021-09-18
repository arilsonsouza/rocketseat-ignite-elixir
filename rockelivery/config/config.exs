# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :rockelivery,
  ecto_repos: [Rockelivery.Repo]

config :rockelivery, Rockelivery.Repo,
  migration_primary_key: [type: :binary_id],
  migration_foreign_key: [type: :binary_id]

# Configures the endpoint
config :rockelivery, RockeliveryWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "CaVgJ2nPbkon1cVTFO5ffjVh0JnFgHfGGbcNjeKYHF+oaPy8FalcVQ8TrqTrZcWU",
  render_errors: [view: RockeliveryWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: Rockelivery.PubSub,
  live_view: [signing_salt: "RmNfE633"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :rockelivery, Rockelivery.Accounts, via_cep_adapter: Rockelivery.ViaCep.Client

config :rockelivery, RockeliveryWeb.Auth.Guardian,
  issuer: "rockelivery",
  secret_key: "RDcuY9rH/GCKyz6dkUv331JADcBOkxZioYJLJNUev1+nds1GcYZo+STKRXK3Tbs6"

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
