defmodule Simplelix.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      SimplelixWeb.Telemetry,
      # Start the Ecto repository
      Simplelix.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: Simplelix.PubSub},
      # Start Finch
      {Finch, name: Simplelix.Finch},
      # Start the Endpoint (http/https)
      SimplelixWeb.Endpoint
      # Start a worker by calling: Simplelix.Worker.start_link(arg)
      # {Simplelix.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Simplelix.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    SimplelixWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
