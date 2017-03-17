
defmodule Todo.Router do
  import Plug.Conn
  use Plug.Router
  plug Plug.Parsers, parsers: [:urlencoded, :multipart]
  # plug Todo.Verify, fields: ["content", "mimetype"], paths: ["/add"]
  plug :match
  plug :dispatch

  get "/" do
    send_resp(conn, 200, "Root Route")
  end

  get "/add" do
    conn = fetch_query_params(conn)
    %{"txt" => txt} = conn.params
    ret = GenServer.call(Storage, {:add, txt})
    IO.puts(ret)
    send_resp(conn, 200, "Added")
  end

  get "/remove" do
    conn = fetch_query_params(conn)
    %{"index" => index} = conn.params
    ret = Todo.Storage.remove(String.to_integer(index))
    IO.puts(ret)
    send_resp(conn, 200, "Removed")
  end

  get "/state" do
    state = Todo.Storage.status()
    send_resp(conn, 200, to_string(state))
  end

  match _, do: send_resp(conn, 404, "Error 404")
end
