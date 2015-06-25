use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :chen, Chen.Endpoint,
  http: [port: 4001],
  server: false,
  secret_key_base: "thisisatestkeyforuseonlywiththetestconfigsdlfkjsdfklj;sdfkljsd;alkfas;ldkjfdksjfslkdfjklsajdf" #Should be at least 64 bytes long

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :chen, Chen.Repo,
  adapter: Ecto.Adapters.MySQL,
  username: "chen_test",
  password: "chentest",
  database: "chen_test",
  size: 1 # Use a single connection for transactional tests
