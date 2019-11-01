defmodule Prism.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :username, :string, size: 64, null: false
      add :password_hash, :string, null: false
      add :first_name, :string, null: false
      add :last_name, :string, null: false
      add :email, :string, null: false

      timestamps()
    end

    create unique_index(:users, [:email])
    create unique_index(:users, [:username])
  end
end
