defmodule ChessWeb.UserController do
  use ChessWeb, :controller
  alias Chess.UserManager
  alias ChessWeb.UserFallbackController

  action_fallback UserFallbackController

  def store(conn, %{"username" => username, "password" => password}) do
    with {:ok, user} <- UserManager.create_user(%{username: username, password: password}) do
      # asdf
      conn
      |> json(%{msg: "User created 134"})
    end
  end
end
