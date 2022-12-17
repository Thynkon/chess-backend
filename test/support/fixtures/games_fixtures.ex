defmodule Chess.GamesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Chess.Games` context.
  """

  @doc """
  Generate a game.
  """
  def game_fixture(attrs \\ %{}) do
    {:ok, game} =
      attrs
      |> Enum.into(%{
        created_at: ~N[2022-12-16 17:29:00],
        finished_at: ~N[2022-12-16 17:29:00],
        level: :"1",
        started_at: ~N[2022-12-16 17:29:00],
        variation: :Standard
      })
      |> Chess.Games.create_game()

    game
  end
end
