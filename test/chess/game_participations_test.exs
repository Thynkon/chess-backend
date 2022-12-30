defmodule Chess.GameParticipationsTest do
  use Chess.DataCase

  alias Chess.GameParticipations

  describe "game_participation" do
    alias Chess.GameParticipations.GameParticipation

    import Chess.GameParticipationsFixtures

    @invalid_attrs %{name: nil}

    test "list_game_participation/0 returns all game_participation" do
      game_participation = game_participation_fixture()
      assert GameParticipations.list_game_participation() == [game_participation]
    end

    test "get_game_participation!/1 returns the game_participation with given id" do
      game_participation = game_participation_fixture()
      assert GameParticipations.get_game_participation!(game_participation.id) == game_participation
    end

    test "create_game_participation/1 with valid data creates a game_participation" do
      valid_attrs = %{name: "some name"}

      assert {:ok, %GameParticipation{} = game_participation} = GameParticipations.create_game_participation(valid_attrs)
      assert game_participation.name == "some name"
    end

    test "create_game_participation/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = GameParticipations.create_game_participation(@invalid_attrs)
    end

    test "update_game_participation/2 with valid data updates the game_participation" do
      game_participation = game_participation_fixture()
      update_attrs = %{name: "some updated name"}

      assert {:ok, %GameParticipation{} = game_participation} = GameParticipations.update_game_participation(game_participation, update_attrs)
      assert game_participation.name == "some updated name"
    end

    test "update_game_participation/2 with invalid data returns error changeset" do
      game_participation = game_participation_fixture()
      assert {:error, %Ecto.Changeset{}} = GameParticipations.update_game_participation(game_participation, @invalid_attrs)
      assert game_participation == GameParticipations.get_game_participation!(game_participation.id)
    end

    test "delete_game_participation/1 deletes the game_participation" do
      game_participation = game_participation_fixture()
      assert {:ok, %GameParticipation{}} = GameParticipations.delete_game_participation(game_participation)
      assert_raise Ecto.NoResultsError, fn -> GameParticipations.get_game_participation!(game_participation.id) end
    end

    test "change_game_participation/1 returns a game_participation changeset" do
      game_participation = game_participation_fixture()
      assert %Ecto.Changeset{} = GameParticipations.change_game_participation(game_participation)
    end
  end
end
