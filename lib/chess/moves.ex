defmodule Chess.Moves do
  @moduledoc """
  The Moves context.
  """

  import Ecto.Query, warn: false
  alias Chess.Repo

  alias Chess.Moves.Move

  @doc """
  Returns the list of move.

  ## Examples

      iex> list_move()
      [%Move{}, ...]

  """
  def list_move do
    Repo.all(Move)
  end

  @doc """
  Gets a single move.

  Raises `Ecto.NoResultsError` if the Move does not exist.

  ## Examples

      iex> get_move!(123)
      %Move{}

      iex> get_move!(456)
      ** (Ecto.NoResultsError)

  """
  def get_move!(id), do: Repo.get!(Move, id)

  @doc """
  Creates a move.

  ## Examples

      iex> create_move(%{field: value})
      {:ok, %Move{}}

      iex> create_move(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_move(attrs \\ %{}) do
    %Move{}
    |> Move.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a move.

  ## Examples

      iex> update_move(move, %{field: new_value})
      {:ok, %Move{}}

      iex> update_move(move, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_move(%Move{} = move, attrs) do
    move
    |> Move.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a move.

  ## Examples

      iex> delete_move(move)
      {:ok, %Move{}}

      iex> delete_move(move)
      {:error, %Ecto.Changeset{}}

  """
  def delete_move(%Move{} = move) do
    Repo.delete(move)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking move changes.

  ## Examples

      iex> change_move(move)
      %Ecto.Changeset{data: %Move{}}

  """
  def change_move(%Move{} = move, attrs \\ %{}) do
    Move.changeset(move, attrs)
  end
end
