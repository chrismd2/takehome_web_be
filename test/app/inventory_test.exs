defmodule App.InventoryTest do
  use App.DataCase

  alias App.Inventory

  describe "units" do
    alias App.Inventory.Unit

    import App.InventoryFixtures

    @invalid_attrs %{category: nil, location_area: nil, location_name: nil, name: nil, price: nil, uuid: nil}

    test "list_units/0 returns all units" do
      unit = unit_fixture()
      assert Inventory.list_units() == [unit]
    end

    test "get_unit!/1 returns the unit with given id" do
      unit = unit_fixture()
      assert Inventory.get_unit!(unit.id) == unit
    end

    test "create_unit/1 with valid data creates a unit" do
      valid_attrs = %{category: "some category", location_area: "some location_area", location_name: "some location_name", name: "some name", price: "some price", uuid: "some uuid"}

      assert {:ok, %Unit{} = unit} = Inventory.create_unit(valid_attrs)
      assert unit.category == "some category"
      assert unit.location_area == "some location_area"
      assert unit.location_name == "some location_name"
      assert unit.name == "some name"
      assert unit.price == "some price"
      assert unit.uuid == "some uuid"
    end

    test "create_unit/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Inventory.create_unit(@invalid_attrs)
    end

    test "update_unit/2 with valid data updates the unit" do
      unit = unit_fixture()
      update_attrs = %{category: "some updated category", location_area: "some updated location_area", location_name: "some updated location_name", name: "some updated name", price: "some updated price", uuid: "some updated uuid"}

      assert {:ok, %Unit{} = unit} = Inventory.update_unit(unit, update_attrs)
      assert unit.category == "some updated category"
      assert unit.location_area == "some updated location_area"
      assert unit.location_name == "some updated location_name"
      assert unit.name == "some updated name"
      assert unit.price == "some updated price"
      assert unit.uuid == "some updated uuid"
    end

    test "update_unit/2 with invalid data returns error changeset" do
      unit = unit_fixture()
      assert {:error, %Ecto.Changeset{}} = Inventory.update_unit(unit, @invalid_attrs)
      assert unit == Inventory.get_unit!(unit.id)
    end

    test "delete_unit/1 deletes the unit" do
      unit = unit_fixture()
      assert {:ok, %Unit{}} = Inventory.delete_unit(unit)
      assert_raise Ecto.NoResultsError, fn -> Inventory.get_unit!(unit.id) end
    end

    test "change_unit/1 returns a unit changeset" do
      unit = unit_fixture()
      assert %Ecto.Changeset{} = Inventory.change_unit(unit)
    end
  end
end
