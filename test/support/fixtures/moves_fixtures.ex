defmodule Chess.MovesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Chess.Moves` context.
  """

  @doc """
  Generate a move.
  """
  def move_fixture(attrs \\ %{}) do
    {:ok, move} =
      attrs
      |> Enum.into(%{
        fen: "some fen"
      })
      |> Chess.Moves.create_move()

    move
  end
end
