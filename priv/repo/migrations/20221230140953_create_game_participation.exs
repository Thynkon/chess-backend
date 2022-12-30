defmodule Chess.Repo.Migrations.CreateGameParticipation do
  use Ecto.Migration

  def change do
    create table(:game_participation, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :user_id, references(:users, on_delete: :delete_all, type: :uuid), null: false
      add :game_id, references(:games, on_delete: :delete_all, type: :uuid), null: false
      add :side, :integer, null: false

      timestamps()
    end
  end
end
