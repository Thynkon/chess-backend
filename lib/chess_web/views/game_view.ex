defmodule ChessWeb.GameView do
  use ChessWeb, :view
  alias ChessWeb.GameView
  require Logger

  def render("store.json", %{game: game}) do
    %{data: render_one(game, GameView, "game.json")}
  end

  def render("game.json", %{game: game}) do
    template = %{
      id: game.id,
      started_at: game.started_at,
      fields: game.fields,
      status_id: game.status_id,
      variant_id: game.variant_id
    }

    template
  end
end
