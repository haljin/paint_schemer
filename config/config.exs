# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :paint_schemer,
  ecto_repos: [PaintSchemer.Repo]

# Configures the endpoint
config :paint_schemer, PaintSchemerWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "HVKX7QHmmpx4lR1kXs2825Gk7q3wEQIoKGcPlTyKgJnSa0Ewk/Eh6rFxCATOviB3",
  render_errors: [view: PaintSchemerWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: PaintSchemer.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
