defmodule ChessWeb.GameController do
  use ChessWeb, :controller
  alias ChessWeb.GameFallbackController
  require Logger

  action_fallback GameFallbackController

  def store(conn, %{"variant" => variant, "type" => type, "level" => level}) do
    variant = Chess.Variants.get_variant_by_name(variant)
    game_type = Chess.GameTypes.get_game_type_by_slug(String.to_atom(type))
    fields = %{level: level}

    with {:ok, game} <-
           Chess.Games.create_game(%{
             started_at: DateTime.utc_now(),
             variant_id: variant.id,
             game_type_id: game_type.id,
             fields: fields
           }) do
      render(conn, "store.json", game: game)
    end
  end
end
