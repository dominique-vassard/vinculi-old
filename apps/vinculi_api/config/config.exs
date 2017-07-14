# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :vinculi_api,
  namespace: VinculiApi,
  ecto_repos: [VinculiApi.Repo]

# Configures the endpoint
config :vinculi_api, VinculiApi.Web.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "9VOUvpVMDrr1KJjo2LKNN3AvZ5/H2ZiQpKr9LykuBgBRnLFYf3EUO9a44E7vtJ6o",
  render_errors: [view: VinculiApi.Web.ErrorView, accepts: ~w(json)],
  pubsub: [name: VinculiApi.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
