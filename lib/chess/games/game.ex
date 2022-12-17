defmodule Chess.Games.Game do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  @timestamps_opts inserted_at: :created_at
  schema "games" do
    field :level, :integer
    field :duration, :integer
    field :variant, Ecto.Enum, values: [:standard, :crazyhouse]
    field :finished_at, :utc_datetime
    field :started_at, :utc_datetime

    timestamps()
    belongs_to :user, Chess.UserManager.User
  end

  @doc false
  def changeset(game, attrs) do
    game
    |> cast(attrs, [
      :created_at,
      :started_at,
      :finished_at,
      :level,
      :variant,
      :user_id,
      :duration
    ])
    |> validate_required([:level, :duration, :variant])
  end

  def finish_changeset(game, attrs) do
    game
    |> cast(attrs, [:finished_at])
    |> validate_required([:finished_at])
  end
end
