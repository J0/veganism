# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :veganism,
  ecto_repos: [Veganism.Repo]

# Configures the endpoint
config :veganism, VeganismWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "syocKqOYkN1EkcXoH5Q2BF3I+fdFY8VS8HQt5RG5WVCVckfCAMrDcfsRd/HPj0wg",
  render_errors: [view: VeganismWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Veganism.PubSub,
  live_view: [signing_salt: "cUDagb3z"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
