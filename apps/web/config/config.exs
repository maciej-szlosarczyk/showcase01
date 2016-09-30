# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :web,
  namespace: Web

# Configures the endpoint
config :web, Web.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "kCiS1yPLGDsbofl91aFym4bwOr55jiCRQoc0cJvnAjSOcX02fIS2ybTNjXeYWtS2",
  render_errors: [view: Web.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Web.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :guardian, Guardian,
  issuer: "Showcase01.Web",
  ttl: {2, :days},
  verify_issuer: true,
  secret_key: "m4BFsHL8XI18/UGO8iP/5u/1XKMIKR36jtesOrs40H/znfMeqpJ+oBGZlWqJO+Wj",
  serializer: Web.GuardianSerializer


# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
