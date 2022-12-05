defmodule Chess.AuthErrorHandler do
  import Plug.Conn
  require Logger

  def auth_error(conn, {type, reason}, opts) do
    Logger.debug("REASON ==> #{inspect(reason)}, OPTIONS ==> #{inspect(opts)}")
    body = Jason.encode!(%{error: to_string(type)})
    send_resp(conn, 401, body)
  end
end
