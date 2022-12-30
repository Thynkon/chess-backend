defmodule Chess.Variants.Variant do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "variants" do
    field :name, :string

    timestamps()
    has_many :games, Chess.Games.Game
  end

  @doc false
  def changeset(variant, attrs) do
    variant
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
