defmodule ChessWeb.StatusControllerTest do
  use ChessWeb.ConnCase

  import Chess.StatusesFixtures

  alias Chess.Statuses.Status

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
    test "lists all statuses", %{conn: conn} do
      conn = get(conn, Routes.status_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create status" do
    test "renders status when data is valid", %{conn: conn} do
      conn = post(conn, Routes.status_path(conn, :create), status: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.status_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "name" => "some name",
               "slug" => "some slug"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.status_path(conn, :create), status: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update status" do
    setup [:create_status]

    test "renders status when data is valid", %{conn: conn, status: %Status{id: id} = status} do
      conn = put(conn, Routes.status_path(conn, :update, status), status: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.status_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "name" => "some updated name",
               "slug" => "some updated slug"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, status: status} do
      conn = put(conn, Routes.status_path(conn, :update, status), status: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete status" do
    setup [:create_status]

    test "deletes chosen status", %{conn: conn, status: status} do
      conn = delete(conn, Routes.status_path(conn, :delete, status))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.status_path(conn, :show, status))
      end
    end
  end

  defp create_status(_) do
    status = status_fixture()
    %{status: status}
  end
end
