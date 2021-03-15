defmodule Veganism.Repo do
  use Ecto.Repo,
    otp_app: :veganism,
    adapter: Ecto.Adapters.Postgres
end
