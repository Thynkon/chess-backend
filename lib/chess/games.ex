defmodule Chess.Games do
  require Logger

  @moduledoc """
  The Games context.
  """

  import Ecto.Query, warn: false
  alias Chess.Repo

  alias Chess.Games.Game
  alias Chess.Statuses

  @doc """
  Returns the list of games.

  ## Examples

      iex> list_games()
      [%Game{}, ...]

  """
  def list_games do
    Repo.all(Game)
    |> Repo.preload(:user)
    |> Repo.preload(:status)
  end

  @doc """
  Gets a single game.

  Raises `Ecto.NoResultsError` if the Game does not exist.

  ## Examples

      iex> get_game!(123)
      %Game{}

      iex> get_game!(456)
      ** (Ecto.NoResultsError)

  """
  def get_game!(id), do: Repo.get!(Game, id) |> Repo.preload(:status)

  @doc """
  Creates a game.

  ## Examples

      iex> create_game(%{field: value})
      {:ok, %Game{}}

      iex> create_game(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_game(attrs \\ %{}) do
    status = Chess.Statuses.get_status_by_slug(:scheduled)

    attrs =
      if status !== nil do
        attrs |> Map.put(:status_id, status.id)
      end

    %Game{}
    |> Game.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a game.

  ## Examples

      iex> update_game(game, %{field: new_value})
      {:ok, %Game{}}

      iex> update_game(game, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_game(%Game{} = game, attrs) do
    game
    |> Game.changeset(attrs)
    |> Repo.update()
  end

  def move_next_status_game(%Game{} = game) do
    Logger.debug("Current status to => #{inspect(game.status.slug)}")

    next_status_slug = next_status(game)
    next_status = Statuses.get_status_by_slug(next_status_slug)

    Logger.debug("Setting status to => #{inspect(next_status.slug)}")
    attrs = %{status_id: next_status.id}

    game =
      game
      |> Game.start_changeset(attrs)
      |> Repo.update!()
      |> Repo.preload(:status, force: true)

    Logger.debug("Updated game status ==> #{inspect(game.status.slug)}")
    game
  end

  @doc """
  Deletes a game.

  ## Examples

      iex> delete_game(game)
      {:ok, %Game{}}

      iex> delete_game(game)
      {:error, %Ecto.Changeset{}}

  """
  def delete_game(%Game{} = game) do
    Repo.delete(game)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking game changes.

  ## Examples

      iex> change_game(game)
      %Ecto.Changeset{data: %Game{}}

  """
  def change_game(%Game{} = game, attrs \\ %{}) do
    Game.changeset(game, attrs)
  end

  defp next_status(%Game{} = game) do
    case game.status.slug do
      :scheduled -> :on_going
      :on_going -> :finished
      :finished -> :archived
      :archived -> :archived
    end
  end
end
