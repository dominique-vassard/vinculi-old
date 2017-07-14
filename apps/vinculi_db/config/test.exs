use Mix.Config

# Print only warnings and errors during test
config :logger, level: :warn

# Comeonin config for test only (faster tests with less rounds)
config :comeonin, :bcrypt_log_rounds, 4

# Configure Vincuyli postgres database
config :vinculi_db, VinculiDb.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "vinculi",
  password: "Koysteuk",
  database: "vinculi_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox