defmodule Simplelix.Repo.Migrations.CreateToys do
  use Ecto.Migration

  def change do
    create table(:toys) do
      add :title, :string
      add :price, :float

      timestamps()
    end

    create unique_index(:toys, [:title])
  end
end
