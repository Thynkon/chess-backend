# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

config :chess,
  ecto_repos: [Chess.Repo],
  generators: [binary_id: true]

# Configures the endpoint
config :chess, ChessWeb.Endpoint,
  url: [host: "localhost"],
  render_errors: [view: ChessWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: Chess.PubSub,
  live_view: [signing_salt: "ObYUrc93"]

# Configures the mailer
#
# By default it uses the "Local" adapter which stores the emails
# locally. You can see the emails in your browser, at "/dev/mailbox".
#
# For production it's recommended to configure a different adapter
# at the `config/runtime.exs`.
config :chess, Chess.Mailer, adapter: Swoosh.Adapters.Local

# Swoosh API client is needed for adapters other than SMTP.
config :swoosh, :api_client, false

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :chess, Chess.UserManager.Guardian,
  issuer: "chess",
  # put the result of the mix command above here
  secret_key: "EfpJ0mAOVv0/v9YqrZ3aEloZLfeH45G5B5OMaHrlLUzMKQJ2UJkc2AKqHer0FtCH"

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"
