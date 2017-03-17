
defmodule Todo.Storage do
  use GenServer

  def start_link(state \\ []) do
    GenServer.start_link(__MODULE__, state, name: Storage)
  end

  def init(state), do: {:ok, state}

  def handle_call({:add, txt}, from, state) do
    {:reply, :added, state ++ [txt]}
  end

  def handle_call({:remove, index}, from, state) do
    {:reply, :removed, List.delete_at(state, index)}
  end

  def handle_call(:status, from, state) do
    {:reply, state, state}
  end

  def add(txt) do
    GenServer.call(Storage, {:add, txt})
  end

  def remove(index) do
    GenServer.call(Storage, {:remove, index})
  end

  def status() do
    GenServer.call(Storage, :status)
  end

end
