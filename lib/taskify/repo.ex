defmodule Taskify.Repo do
  use Ecto.Repo,
    otp_app: :taskify,
    adapter: Ecto.Adapters.Postgres
end
