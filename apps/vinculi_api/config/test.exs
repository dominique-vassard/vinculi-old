use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :vinculi_api, VinculiApi.Web.Endpoint,
  http: [port: 4401],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure  Neo4J database
config :bolt_sips, Bolt,
  hostname: "localhost",
  port: 7688,
  pool_size: 5,
  max_overflow: 1,
  basic_auth: ["username": "neo4j", "password": "Goreydyi"]
