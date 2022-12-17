defmodule Chess.Repo.Migrations.CreateGames do
  use Ecto.Migration

  def change do
    create table(:games, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :user_id, references(:users, on_delete: :delete_all, type: :uuid), null: false
      add :started_at, :utc_datetime
      add :finished_at, :utc_datetime, null: true
      add :level, :integer
      add :duration, :integer
      add :variant, :string

      timestamps(inserted_at: :created_at, type: :utc_datetime)
    end
  end
end
