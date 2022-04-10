defmodule App.Inventory.Unit do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "units" do
    field :category, :string
    field :location_area, :string
    field :location_name, :string
    field :name, :string
    field :price, :string
    field :uuid, :string

    timestamps()
  end

  @doc false
  def changeset(unit, attrs) do
    unit
    |> cast(attrs, [:uuid, :name, :price, :category, :location_name, :location_area])
    |> validate_required([:uuid, :name, :price, :category, :location_name, :location_area])
  end
end
