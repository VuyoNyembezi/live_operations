defmodule LiveOperations.Repo do
  use Ecto.Repo,
    otp_app: :live_operations,
    adapter: Ecto.Adapters.Postgres
end
