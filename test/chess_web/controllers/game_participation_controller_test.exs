defmodule ChessWeb.GameParticipationControllerTest do
  use ChessWeb.ConnCase

  import Chess.GameParticipationsFixtures

  alias Chess.GameParticipations.GameParticipation

  @create_attrs %{
    name: "some name"
  }
  @update_attrs %{
    name: "some updated name"
  }
  @invalid_attrs %{name: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all game_participation", %{conn: conn} do
      conn = get(conn, Routes.game_participation_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create game_participation" do
    test "renders game_participation when data is valid", %{conn: conn} do
      conn = post(conn, Routes.game_participation_path(conn, :create), game_participation: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.game_participation_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "name" => "some name"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.game_participation_path(conn, :create), game_participation: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update game_participation" do
    setup [:create_game_participation]

    test "renders game_participation when data is valid", %{conn: conn, game_participation: %GameParticipation{id: id} = game_participation} do
      conn = put(conn, Routes.game_participation_path(conn, :update, game_participation), game_participation: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.game_participation_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "name" => "some updated name"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, game_participation: game_participation} do
      conn = put(conn, Routes.game_participation_path(conn, :update, game_participation), game_participation: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete game_participation" do
    setup [:create_game_participation]

    test "deletes chosen game_participation", %{conn: conn, game_participation: game_participation} do
      conn = delete(conn, Routes.game_participation_path(conn, :delete, game_participation))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.game_participation_path(conn, :show, game_participation))
      end
    end
  end

  defp create_game_participation(_) do
    game_participation = game_participation_fixture()
    %{game_participation: game_participation}
  end
end
