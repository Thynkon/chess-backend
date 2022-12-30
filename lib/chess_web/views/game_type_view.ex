defmodule ChessWeb.GameTypeView do
  use ChessWeb, :view
  alias ChessWeb.GameTypeView

  def render("index.json", %{game_types: game_types}) do
    %{data: render_many(game_types, GameTypeView, "game_type.json")}
  end

  def render("show.json", %{game_type: game_type}) do
    %{data: render_one(game_type, GameTypeView, "game_type.json")}
  end

  def render("game_type.json", %{game_type: game_type}) do
    %{
      id: game_type.id,
      name: game_type.name,
      slug: game_type.slug
    }
  end
end
