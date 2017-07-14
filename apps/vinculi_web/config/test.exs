use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :vinculi_web, VinculiWeb.Web.Endpoint,
  http: [port: 4001],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :vinculi_web, VinculiWeb.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "vinculi",
  password: "Koysteuk",
  database: "vinculi_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox
