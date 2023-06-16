defmodule Simplelix.Repo do
  use Ecto.Repo,
    otp_app: :simplelix,
    adapter: Ecto.Adapters.Postgres
end
