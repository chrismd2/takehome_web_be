defmodule Mix.Tasks.ImportProducts do
  @moduledoc """
  Task to import sample products data.
  """
  alias App.Repo
  use Mix.Task

  @shortdoc "Import product data"
  @impl true
  def run(filename \\ "support/data.csv") do
    Ecto.Migrator.with_repo(Repo, fn _repo ->
      IO.puts("Importing #{filename} to the DB...")
      File.ls|>IO.inspect
      # Get the data in the .csv and convert it into a list
      [keys | data] = "../../../#{filename}"
      |> Path.expand(__DIR__)
      |> File.stream!
      |> CSV.decode!
      |> Enum.to_list
      # NOTE: This gets handled by the changeset
      # # Reject any records that any col is an empty string
      # |> Enum.reject(fn(list) ->
      #       Enum.any?(list, fn(str) -> str == "" end) end)
      records_list = Enum.map(data, fn(record_data) ->
        Enum.zip(keys, record_data)
        |> Map.new(fn({k, v}) -> {String.to_atom(k), v} end) end)

      Enum.map(records_list, fn(r) -> App.Inventory.create_unit(r) end)
      # |> IO.inspect(label: "insert status")
    end)
  end
end
