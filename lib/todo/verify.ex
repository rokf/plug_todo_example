defmodule Todo.Verify do
  defmodule IncompleteRequestError do
    @moduledoc """
    Something is missing in your request.
    """
    defexception message: "", plug_status: 400
  end

  def init(options), do: options

  def call(%Plug.Conn{request_path: path} = conn, opts) do
    if path in opts[:paths] do
      verify_request!(conn.body_params, opts[:fields])
    end
    conn
  end

  defp verify_request!(body_params, fields) do
    verified = body_params
      |> Map.keys
      |> contains_fields?(fields)
    unless verified do
      raise IncompleteRequestError
    end
  end

  defp contains_fields?(keys, fields) do
    Enum.all?(fields, &(&1 in keys))
  end
end
