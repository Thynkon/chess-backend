defmodule ChessWeb.GameTypeController do
  use ChessWeb, :controller

  alias Chess.GameTypes
  alias Chess.GameTypes.GameType

  action_fallback ChessWeb.FallbackController

  def index(conn, _params) do
    game_types = GameTypes.list_game_types()
    render(conn, "index.json", game_types: game_types)
  end

  def create(conn, %{"game_type" => game_type_params}) do
    with {:ok, %GameType{} = game_type} <- GameTypes.create_game_type(game_type_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.game_type_path(conn, :show, game_type))
      |> render("show.json", game_type: game_type)
    end
  end

  def show(conn, %{"id" => id}) do
    game_type = GameTypes.get_game_type!(id)
    render(conn, "show.json", game_type: game_type)
  end

  def update(conn, %{"id" => id, "game_type" => game_type_params}) do
    game_type = GameTypes.get_game_type!(id)

    with {:ok, %GameType{} = game_type} <- GameTypes.update_game_type(game_type, game_type_params) do
      render(conn, "show.json", game_type: game_type)
    end
  end

  def delete(conn, %{"id" => id}) do
    game_type = GameTypes.get_game_type!(id)

    with {:ok, %GameType{}} <- GameTypes.delete_game_type(game_type) do
      send_resp(conn, :no_content, "")
    end
  end
end
