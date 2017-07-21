use Mix.Config

# Ars Magica DB configuration
config :ars_magica, ArsMagica.Repo,
  adapter: Ecto.Adapters.MySQL,
  username: "arsmagbdd",
  password: "Nougat13250jhk",
  hostname: "sqlprive-bc52475-001.privatesql",
  database: "arsmagbdd"