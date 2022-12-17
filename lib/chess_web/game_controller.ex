defmodule ChessWeb.GameController do
  use ChessWeb, :controller
  alias ChessWeb.GameFallbackController
  require Logger

  action_fallback GameFallbackController

  def store(conn, %{
        "level" => level,
        "variant" => variant,
        "duration" => duration
      }) do
    Logger.debug(inspect(conn.assigns))
    # Logger.debug(Guardian.Plug.current_resource(conn))
    # {:ok, claims} = Chess.Tokens.decode_and_verify(token)
    with {:ok, _game} <-
           Chess.Games.create_game(%{
             started_at: DateTime.utc_now(),
             level: level,
             variant: variant,
             duration: duration,
             user_id: conn.assigns.current_user.id
           }) do
      conn |> json(%{msg: "Game created!"})
    end

    # with {:ok, user} <- UserManager.create_user(%{username: username, password: password}) do
    #   # asdf
    #   conn
    #   |> json(%{msg: "User created"})
    # end
  end
end
