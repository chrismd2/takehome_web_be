defmodule App.Repo.Migrations.CreateUnits do
  use Ecto.Migration

  def change do
    create table(:units, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :uuid, :string
      add :name, :string
      add :price, :string
      add :category, :string
      add :location_name, :string
      add :location_area, :string

      timestamps()
    end
  end
end
