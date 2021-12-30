defmodule Samdelivery.Repo do
  use Ecto.Repo,
    otp_app: :samdelivery,
    adapter: Ecto.Adapters.Postgres
end
