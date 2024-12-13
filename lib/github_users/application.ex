defmodule GithubUsers.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      GithubUsersWeb.Telemetry,
      {DNSCluster, query: Application.get_env(:github_users, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: GithubUsers.PubSub},
      # Start a worker by calling: GithubUsers.Worker.start_link(arg)
      # {GithubUsers.Worker, arg},
      # Start to serve requests, typically the last entry
      GithubUsersWeb.Endpoint,
      {Finch, name: MyFinch}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: GithubUsers.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    GithubUsersWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
