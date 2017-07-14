defmodule VinculiDb.Application do
  # See http://elixir-lang.org/docs/stable/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    # Define workers and child supervisors to be supervised
    children = [
      # Start REpo supervisor
      supervisor(VinculiDb.Repo, [])
      # Starts a worker by calling: VinculiDb.Worker.start_link(arg1, arg2, arg3)
      # worker(VinculiDb.Worker, [arg1, arg2, arg3]),
    ]

    # See http://elixir-lang.org/docs/stable/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: VinculiDb.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
