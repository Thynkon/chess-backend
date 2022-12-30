defmodule ChessWeb.GameTypeControllerTest do
  use ChessWeb.ConnCase

  import Chess.GameTypesFixtures

  alias Chess.GameTypes.GameType

  @create_attrs %{
    name: "some name",
    slug: "some slug"
  }
  @update_attrs %{
    name: "some updated name",
    slug: "some updated slug"
  }
  @invalid_attrs %{name: nil, slug: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all game_types", %{conn: conn} do
      conn = get(conn, Routes.game_type_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create game_type" do
    test "renders game_type when data is valid", %{conn: conn} do
      conn = post(conn, Routes.game_type_path(conn, :create), game_type: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.game_type_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "name" => "some name",
               "slug" => "some slug"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.game_type_path(conn, :create), game_type: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update game_type" do
    setup [:create_game_type]

    test "renders game_type when data is valid", %{conn: conn, game_type: %GameType{id: id} = game_type} do
      conn = put(conn, Routes.game_type_path(conn, :update, game_type), game_type: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.game_type_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "name" => "some updated name",
               "slug" => "some updated slug"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, game_type: game_type} do
      conn = put(conn, Routes.game_type_path(conn, :update, game_type), game_type: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete game_type" do
    setup [:create_game_type]

    test "deletes chosen game_type", %{conn: conn, game_type: game_type} do
      conn = delete(conn, Routes.game_type_path(conn, :delete, game_type))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.game_type_path(conn, :show, game_type))
      end
    end
  end

  defp create_game_type(_) do
    game_type = game_type_fixture()
    %{game_type: game_type}
  end
end
