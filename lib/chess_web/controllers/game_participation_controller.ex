defmodule ChessWeb.GameParticipationController do
  use ChessWeb, :controller

  alias Chess.GameParticipations
  alias Chess.GameParticipations.GameParticipation

  require Logger

  action_fallback ChessWeb.FallbackController

  def index(conn, _params) do
    game_participation = GameParticipations.list_game_participation()
    render(conn, "index.json", game_participation: game_participation)
  end

  def create(conn, %{"game_id" => _game_id} = game_participation_params) do
    user = conn.assigns.current_user
    # side = Enum.random([:white, :black])
    # This is a temporary 'fix'.
    side = :white
    game_participation_params = game_participation_params |> Map.put("user_id", user.id)
    game_participation_params = game_participation_params |> Map.put("side", side)

    Logger.debug("GOT ==> #{inspect(game_participation_params)}")

    with {:ok, %GameParticipation{} = game_participation} <-
           GameParticipations.create_game_participation(game_participation_params) do
      conn
      |> put_status(:created)
      # |> put_resp_header(
      #   "location",
      #   Routes.game_participation_path(conn, :show, game_participation)
      # )
      |> render("show.json", game_participation: game_participation)
    end
  end

  def show(conn, %{"id" => id}) do
    game_participation = GameParticipations.get_game_participation!(id)
    render(conn, "show.json", game_participation: game_participation)
  end

  def update(conn, %{"id" => id, "game_participation" => game_participation_params}) do
    game_participation = GameParticipations.get_game_participation!(id)

    with {:ok, %GameParticipation{} = game_participation} <-
           GameParticipations.update_game_participation(
             game_participation,
             game_participation_params
           ) do
      render(conn, "show.json", game_participation: game_participation)
    end
  end

  def delete(conn, %{"id" => id}) do
    game_participation = GameParticipations.get_game_participation!(id)

    with {:ok, %GameParticipation{}} <-
           GameParticipations.delete_game_participation(game_participation) do
      send_resp(conn, :no_content, "")
    end
  end
end
