# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :web,
  namespace: Showcase01.Web

# Configures the endpoint
config :web, Showcase01.Web.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "kCiS1yPLGDsbofl91aFym4bwOr55jiCRQoc0cJvnAjSOcX02fIS2ybTNjXeYWtS2",
  render_errors: [view: Showcase01.Web.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Showcase01.Web.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
