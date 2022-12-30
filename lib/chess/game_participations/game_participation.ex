defmodule Chess.GameParticipations.GameParticipation do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "game_participation" do
    field :side, Ecto.Enum, values: [white: 0, black: 1]
    belongs_to :user, Chess.UserManager.User
    belongs_to :game, Chess.Games.Game
    timestamps()
  end

  @doc false
  def changeset(game_participation, attrs) do
    game_participation
    |> cast(attrs, [:user_id, :game_id, :side])
    |> validate_required([:user_id, :game_id, :side])
  end
end
