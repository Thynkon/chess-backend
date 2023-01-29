defmodule Chess.Statuses.Status do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "statuses" do
    field(:name, :string)
    field(:slug, Chess.Util.AtomType)
    timestamps()

    has_many(:games, Chess.Games.Game)
  end

  @doc false
  def changeset(status, attrs) do
    status
    |> cast(attrs, [:name, :slug])
    |> validate_required([:name, :slug])
    |> unique_constraint(:slug)
  end
end
