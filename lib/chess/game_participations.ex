defmodule Chess.GameParticipations do
  @moduledoc """
  The GameParticipations context.
  """

  import Ecto.Query, warn: false
  alias Chess.Repo

  alias Chess.GameParticipations.GameParticipation

  @doc """
  Returns the list of game_participation.

  ## Examples

      iex> list_game_participation()
      [%GameParticipation{}, ...]

  """
  def list_game_participation do
    Repo.all(GameParticipation)
  end

  @doc """
  Gets a single game_participation.

  Raises `Ecto.NoResultsError` if the Game participation does not exist.

  ## Examples

      iex> get_game_participation!(123)
      %GameParticipation{}

      iex> get_game_participation!(456)
      ** (Ecto.NoResultsError)

  """
  def get_game_participation!(id), do: Repo.get!(GameParticipation, id)

  @doc """
  Creates a game_participation.

  ## Examples

      iex> create_game_participation(%{field: value})
      {:ok, %GameParticipation{}}

      iex> create_game_participation(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_game_participation(attrs \\ %{}) do
    %GameParticipation{}
    |> GameParticipation.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a game_participation.

  ## Examples

      iex> update_game_participation(game_participation, %{field: new_value})
      {:ok, %GameParticipation{}}

      iex> update_game_participation(game_participation, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_game_participation(%GameParticipation{} = game_participation, attrs) do
    game_participation
    |> GameParticipation.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a game_participation.

  ## Examples

      iex> delete_game_participation(game_participation)
      {:ok, %GameParticipation{}}

      iex> delete_game_participation(game_participation)
      {:error, %Ecto.Changeset{}}

  """
  def delete_game_participation(%GameParticipation{} = game_participation) do
    Repo.delete(game_participation)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking game_participation changes.

  ## Examples

      iex> change_game_participation(game_participation)
      %Ecto.Changeset{data: %GameParticipation{}}

  """
  def change_game_participation(%GameParticipation{} = game_participation, attrs \\ %{}) do
    GameParticipation.changeset(game_participation, attrs)
  end
end
