defmodule ChessWeb.SessionController do
  use ChessWeb, :controller

  alias Chess.{UserManager, UserManager.Guardian}
  alias ChessWeb.SessionFallbackController

  action_fallback SessionFallbackController

  def login(conn, %{"username" => username, "password" => password}) do
    with {:ok, user} <- UserManager.authenticate_user(username, password) do
      conn
      |> json(%{msg: "User authenticated"})
    end
  end

  def logout(conn, _) do
    conn
    |> Guardian.Plug.sign_out()
  end
end
