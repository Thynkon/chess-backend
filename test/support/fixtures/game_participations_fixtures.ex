defmodule Chess.GameParticipationsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Chess.GameParticipations` context.
  """

  @doc """
  Generate a game_participation.
  """
  def game_participation_fixture(attrs \\ %{}) do
    {:ok, game_participation} =
      attrs
      |> Enum.into(%{
        name: "some name"
      })
      |> Chess.GameParticipations.create_game_participation()

    game_participation
  end
end
