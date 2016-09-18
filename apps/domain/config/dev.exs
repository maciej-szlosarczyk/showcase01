use Mix.Config

config :domain, Domain.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "showcase01_dev",
  hostname: "localhost",
  pool_size: 10
