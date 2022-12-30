defmodule Chess.GameTypesTest do
  use Chess.DataCase

  alias Chess.GameTypes

  describe "game_types" do
    alias Chess.GameTypes.GameType

    import Chess.GameTypesFixtures

    @invalid_attrs %{name: nil, slug: nil}

    test "list_game_types/0 returns all game_types" do
      game_type = game_type_fixture()
      assert GameTypes.list_game_types() == [game_type]
    end

    test "get_game_type!/1 returns the game_type with given id" do
      game_type = game_type_fixture()
      assert GameTypes.get_game_type!(game_type.id) == game_type
    end

    test "create_game_type/1 with valid data creates a game_type" do
      valid_attrs = %{name: "some name", slug: "some slug"}

      assert {:ok, %GameType{} = game_type} = GameTypes.create_game_type(valid_attrs)
      assert game_type.name == "some name"
      assert game_type.slug == "some slug"
    end

    test "create_game_type/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = GameTypes.create_game_type(@invalid_attrs)
    end

    test "update_game_type/2 with valid data updates the game_type" do
      game_type = game_type_fixture()
      update_attrs = %{name: "some updated name", slug: "some updated slug"}

      assert {:ok, %GameType{} = game_type} = GameTypes.update_game_type(game_type, update_attrs)
      assert game_type.name == "some updated name"
      assert game_type.slug == "some updated slug"
    end

    test "update_game_type/2 with invalid data returns error changeset" do
      game_type = game_type_fixture()
      assert {:error, %Ecto.Changeset{}} = GameTypes.update_game_type(game_type, @invalid_attrs)
      assert game_type == GameTypes.get_game_type!(game_type.id)
    end

    test "delete_game_type/1 deletes the game_type" do
      game_type = game_type_fixture()
      assert {:ok, %GameType{}} = GameTypes.delete_game_type(game_type)
      assert_raise Ecto.NoResultsError, fn -> GameTypes.get_game_type!(game_type.id) end
    end

    test "change_game_type/1 returns a game_type changeset" do
      game_type = game_type_fixture()
      assert %Ecto.Changeset{} = GameTypes.change_game_type(game_type)
    end
  end
end
