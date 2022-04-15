defmodule Mix.Tasks.ImportProductsTest do
  use App.DataCase

  alias Mix.Tasks.ImportProducts

  test "run\1 takes a given file and imports it to the database" do
    {status, list, []} = ImportProducts.run("support/test_data.csv")
    assert status == :ok

    # There are only 7 valid records in the data set
    list = App.Inventory.list_units
    assert Enum.count(list) == 7
  end
  test "run\0 assumes support/data.csv exists and imports it to the database" do
    {status, list, []} = ImportProducts.run
    assert status == :ok

    # There are only 7 valid records in the data set
    list = App.Inventory.list_units
    assert Enum.count(list) == 7
  end
end
