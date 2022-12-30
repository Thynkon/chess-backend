defmodule Chess.StatusesTest do
  use Chess.DataCase

  alias Chess.Statuses

  describe "statuses" do
    alias Chess.Statuses.Status

    import Chess.StatusesFixtures

    @invalid_attrs %{name: nil, slug: nil}

    test "list_statuses/0 returns all statuses" do
      status = status_fixture()
      assert Statuses.list_statuses() == [status]
    end

    test "get_status!/1 returns the status with given id" do
      status = status_fixture()
      assert Statuses.get_status!(status.id) == status
    end

    test "create_status/1 with valid data creates a status" do
      valid_attrs = %{name: "some name", slug: "some slug"}

      assert {:ok, %Status{} = status} = Statuses.create_status(valid_attrs)
      assert status.name == "some name"
      assert status.slug == "some slug"
    end

    test "create_status/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Statuses.create_status(@invalid_attrs)
    end

    test "update_status/2 with valid data updates the status" do
      status = status_fixture()
      update_attrs = %{name: "some updated name", slug: "some updated slug"}

      assert {:ok, %Status{} = status} = Statuses.update_status(status, update_attrs)
      assert status.name == "some updated name"
      assert status.slug == "some updated slug"
    end

    test "update_status/2 with invalid data returns error changeset" do
      status = status_fixture()
      assert {:error, %Ecto.Changeset{}} = Statuses.update_status(status, @invalid_attrs)
      assert status == Statuses.get_status!(status.id)
    end

    test "delete_status/1 deletes the status" do
      status = status_fixture()
      assert {:ok, %Status{}} = Statuses.delete_status(status)
      assert_raise Ecto.NoResultsError, fn -> Statuses.get_status!(status.id) end
    end

    test "change_status/1 returns a status changeset" do
      status = status_fixture()
      assert %Ecto.Changeset{} = Statuses.change_status(status)
    end
  end
end
