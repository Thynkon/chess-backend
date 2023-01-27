defmodule Chess.Repo.Migrations.AddUniqueConstraintToMoveFen do
  use Ecto.Migration

  def change do
    create(unique_index(:moves, [:fen, :game_id]))
  end
end
