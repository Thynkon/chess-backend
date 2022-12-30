defmodule ChessWeb.GameParticipationView do
  use ChessWeb, :view
  alias ChessWeb.GameParticipationView

  def render("index.json", %{game_participation: game_participation}) do
    %{data: render_many(game_participation, GameParticipationView, "game_participation.json")}
  end

  def render("show.json", %{game_participation: game_participation}) do
    %{data: render_one(game_participation, GameParticipationView, "game_participation.json")}
  end

  def render("game_participation.json", %{game_participation: game_participation}) do
    %{
      id: game_participation.id,
      user_id: game_participation.user_id,
      game_id: game_participation.game_id
    }
  end
end
