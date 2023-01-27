defmodule Chess.Repo.Migrations.CreateMoves do
  use Ecto.Migration

  def change do
    create table(:moves, primary_key: false) do
      add(:id, :binary_id, primary_key: true)
      add(:fen, :string)
      add(:game_id, references(:games, on_delete: :delete_all, type: :uuid), null: false)

      timestamps()
    end
  end
end
