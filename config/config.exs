# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# Configures the endpoint
config :chen, Chen.Endpoint,
  url: [host: "localhost"],
  root: Path.dirname(__DIR__),
  secret_key_base: "some secret key", #Should be at least 64 bytes long
  debug_errors: false,
  pubsub: [name: Chen.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :chen, :cdn,
  cdn_path: "/path/to/files",
  cdn_url: "example.com", # Plain URL for CDN with root pointing to cdn_path
  cdn_overwrite: false, #Overwrite files with colliding names TODO
  cdn_name_retries: 5 # Retries if a name collision occurs and overwrite is false TODO

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
