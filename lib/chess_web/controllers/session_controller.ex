defmodule ChessWeb.SessionController do
  use ChessWeb, :controller
  require Logger

  alias Chess.UserManager
  alias ChessWeb.SessionFallbackController
  alias Chess.Guardian

  action_fallback SessionFallbackController

  def login(conn, %{"username" => username, "password" => password}) do
    with {:ok, user} <- UserManager.authenticate_user(username, password) do
      {:ok, token, _claims} = Chess.Guardian.encode_and_sign(user)

      conn
      |> json(%{token: token, user: user})
    end
  end

  def logout(conn, _) do
    jwt = Guardian.Plug.current_token(conn)
    Logger.debug("CURRENT JWT ==> #{inspect(jwt)}")
    Guardian.revoke(jwt)
    conn |> json(%{old_token: jwt})
  end
end
