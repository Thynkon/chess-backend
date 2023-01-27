defmodule Chess.MovesTest do
  use Chess.DataCase

  alias Chess.Moves

  describe "move" do
    alias Chess.Moves.Move

    import Chess.MovesFixtures

    @invalid_attrs %{fen: nil}

    test "list_move/0 returns all move" do
      move = move_fixture()
      assert Moves.list_move() == [move]
    end

    test "get_move!/1 returns the move with given id" do
      move = move_fixture()
      assert Moves.get_move!(move.id) == move
    end

    test "create_move/1 with valid data creates a move" do
      valid_attrs = %{fen: "some fen"}

      assert {:ok, %Move{} = move} = Moves.create_move(valid_attrs)
      assert move.fen == "some fen"
    end

    test "create_move/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Moves.create_move(@invalid_attrs)
    end

    test "update_move/2 with valid data updates the move" do
      move = move_fixture()
      update_attrs = %{fen: "some updated fen"}

      assert {:ok, %Move{} = move} = Moves.update_move(move, update_attrs)
      assert move.fen == "some updated fen"
    end

    test "update_move/2 with invalid data returns error changeset" do
      move = move_fixture()
      assert {:error, %Ecto.Changeset{}} = Moves.update_move(move, @invalid_attrs)
      assert move == Moves.get_move!(move.id)
    end

    test "delete_move/1 deletes the move" do
      move = move_fixture()
      assert {:ok, %Move{}} = Moves.delete_move(move)
      assert_raise Ecto.NoResultsError, fn -> Moves.get_move!(move.id) end
    end

    test "change_move/1 returns a move changeset" do
      move = move_fixture()
      assert %Ecto.Changeset{} = Moves.change_move(move)
    end
  end
end
