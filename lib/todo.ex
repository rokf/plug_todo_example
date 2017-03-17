
defmodule Todo do
  use Application
  require Logger
  def start(_type, _args) do
    port = Application.get_env(:todo, :cport, 8080)
    children = [
      Supervisor.Spec.worker(Todo.Storage, [], [name: Storage]),
      Plug.Adapters.Cowboy.child_spec(:http, Todo.Router, [], port: port)
    ]
    Logger.info "Application Todo started!"
    Supervisor.start_link(children, strategy: :one_for_one)
  end
end
