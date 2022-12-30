defmodule Chess.GameTypes.GameType do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "game_types" do
    field :name, :string
    field :slug, :string

    timestamps()
    has_many :games, Chess.Games.Game
  end

  @doc false
  def changeset(game_type, attrs) do
    game_type
    |> cast(attrs, [:name, :slug])
    |> validate_required([:name, :slug])
  end
end
