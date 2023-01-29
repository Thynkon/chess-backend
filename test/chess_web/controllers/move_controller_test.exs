defmodule ChessWeb.MoveControllerTest do
  use ChessWeb.ConnCase

  import Chess.MovesFixtures

  alias Chess.Moves.Move

  @create_attrs %{
    fen: "some fen"
  }
  @update_attrs %{
    fen: "some updated fen"
  }
  @invalid_attrs %{fen: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all move", %{conn: conn} do
      conn = get(conn, Routes.move_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create move" do
    test "renders move when data is valid", %{conn: conn} do
      conn = post(conn, Routes.move_path(conn, :create), move: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.move_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "fen" => "some fen"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.move_path(conn, :create), move: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update move" do
    setup [:create_move]

    test "renders move when data is valid", %{conn: conn, move: %Move{id: id} = move} do
      conn = put(conn, Routes.move_path(conn, :update, move), move: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.move_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "fen" => "some updated fen"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, move: move} do
      conn = put(conn, Routes.move_path(conn, :update, move), move: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete move" do
    setup [:create_move]

    test "deletes chosen move", %{conn: conn, move: move} do
      conn = delete(conn, Routes.move_path(conn, :delete, move))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.move_path(conn, :show, move))
      end
    end
  end

  defp create_move(_) do
    move = move_fixture()
    %{move: move}
  end
end
