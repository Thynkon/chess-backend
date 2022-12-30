defmodule ChessWeb.VariantControllerTest do
  use ChessWeb.ConnCase

  import Chess.VariantsFixtures

  alias Chess.Variants.Variant

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
    test "lists all variants", %{conn: conn} do
      conn = get(conn, Routes.variant_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create variant" do
    test "renders variant when data is valid", %{conn: conn} do
      conn = post(conn, Routes.variant_path(conn, :create), variant: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.variant_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "name" => "some name"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.variant_path(conn, :create), variant: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update variant" do
    setup [:create_variant]

    test "renders variant when data is valid", %{conn: conn, variant: %Variant{id: id} = variant} do
      conn = put(conn, Routes.variant_path(conn, :update, variant), variant: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.variant_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "name" => "some updated name"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, variant: variant} do
      conn = put(conn, Routes.variant_path(conn, :update, variant), variant: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete variant" do
    setup [:create_variant]

    test "deletes chosen variant", %{conn: conn, variant: variant} do
      conn = delete(conn, Routes.variant_path(conn, :delete, variant))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.variant_path(conn, :show, variant))
      end
    end
  end

  defp create_variant(_) do
    variant = variant_fixture()
    %{variant: variant}
  end
end
