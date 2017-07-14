# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :vinculi_web,
  namespace: VinculiWeb,
  ecto_repos: [VinculiWeb.Repo]

# Configures the endpoint
config :vinculi_web, VinculiWeb.Web.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "5rrBjUzJsY0xjZKJSXKEB0LAEWCYYh8eEcLUtbi2+dvPKCq/J/E4xyZ/5wI75Lor",
  render_errors: [view: VinculiWeb.Web.ErrorView, accepts: ~w(html json)],
  pubsub: [name: VinculiWeb.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
