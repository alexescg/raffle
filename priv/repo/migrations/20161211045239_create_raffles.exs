defmodule Raffle.Repo.Migrations.CreateRaffle do
  use Ecto.Migration

  def change do
    create table(:raffles) do
      add :url, :string
      add :title, :string
      add :description, :text
      add :user_id, references(:users, on_delete: :nothing)

      timestamps()
    end
    create index(:raffles, [:user_id])

  end

end
