defmodule Chess.Moves.Move do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "moves" do
    field(:fen, :string)

    timestamps()
    belongs_to(:game, Chess.Games.Game)
  end

  @doc false
  def changeset(move, attrs) do
    move
    |> cast(attrs, [:fen, :game_id])
    |> validate_required([:fen, :game_id])
  end
end
