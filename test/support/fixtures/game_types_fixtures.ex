defmodule Chess.GameTypesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Chess.GameTypes` context.
  """

  @doc """
  Generate a game_type.
  """
  def game_type_fixture(attrs \\ %{}) do
    {:ok, game_type} =
      attrs
      |> Enum.into(%{
        name: "some name",
        slug: "some slug"
      })
      |> Chess.GameTypes.create_game_type()

    game_type
  end
end
