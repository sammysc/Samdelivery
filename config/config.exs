# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :samdelivery,
  ecto_repos: [Samdelivery.Repo]

#alterado conforme projeto

config :samdelivery, Samdelivery.Repo,
  migration_primary_key: [type: :binary_id],
  migration_foreign_key: [type: :binary_id]

# Configures the endpoint
config :samdelivery, SamdeliveryWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "65QAslByVXWABC0Xm5rQwC4AyEBR+N3Wd+DWihPGl9HXfwt7IAyDKy02ck6Afann",
  render_errors: [view: SamdeliveryWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: Samdelivery.PubSub,
  live_view: [signing_salt: "U5bTk8VD"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
