defmodule Chess.Games.Game do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  @timestamps_opts inserted_at: :created_at
  schema "games" do
    field(:finished_at, :utc_datetime)
    field(:started_at, :utc_datetime)
    field(:fields, :map)

    timestamps()
    belongs_to(:user, Chess.UserManager.User)
    belongs_to(:status, Chess.Statuses.Status, on_replace: :update)
    belongs_to(:variant, Chess.Variants.Variant)
    belongs_to(:game_type, Chess.GameTypes.GameType)
    has_many(:game_participations, Chess.GameParticipations.GameParticipation)
    has_many(:moves, Chess.Moves.Move)
  end

  @doc false
  def changeset(game, attrs) do
    game
    |> cast(attrs, [
      :created_at,
      :started_at,
      :finished_at,
      :status_id,
      :variant_id,
      :game_type_id,
      :fields
    ])
    |> validate_required([:variant_id, :status_id, :game_type_id, :fields])
  end

  def start_changeset(game, attrs) do
    game
    |> cast(attrs, [:status_id])
    |> validate_required([:status_id])
  end

  def finish_changeset(game, attrs) do
    game
    |> cast(attrs, [:finished_at])
    |> validate_required([:finished_at])
  end
end
