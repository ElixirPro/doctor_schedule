# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :doctor_schedule,
  ecto_repos: [DoctorSchedule.Repo]

# Configures the endpoint
config :doctor_schedule, DoctorScheduleWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "FsJPPmFvTvyzn4vVWFoOHeeUu0ExBjofQ/FPqcS6C89/bTDCXAHW+5cXT7bjxBST",
  render_errors: [view: DoctorScheduleWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: DoctorSchedule.PubSub,
  live_view: [signing_salt: "0bWA9+R2"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :doctor_schedule, DoctorScheduleWeb.Auth.Guardian,
  issuer: "doctor_schedule",
  secret_key: System.get_env("GUARDIAN_KEY")

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
