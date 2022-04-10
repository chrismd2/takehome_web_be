defmodule App.InventoryFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `App.Inventory` context.
  """

  @doc """
  Generate a unit.
  """
  def unit_fixture(attrs \\ %{}) do
    {:ok, unit} =
      attrs
      |> Enum.into(%{
        category: "some category",
        location_area: "some location_area",
        location_name: "some location_name",
        name: "some name",
        price: "some price",
        uuid: "some uuid"
      })
      |> App.Inventory.create_unit()

    unit
  end
end
