defmodule ChessWeb.MoveView do
  use ChessWeb, :view
  alias ChessWeb.MoveView

  def render("index.json", %{move: move}) do
    %{data: render_many(move, MoveView, "move.json")}
  end

  def render("show.json", %{move: move}) do
    %{data: render_one(move, MoveView, "move.json")}
  end

  def render("move.json", %{move: move}) do
    %{
      id: move.id,
      fen: move.fen
    }
  end
end
