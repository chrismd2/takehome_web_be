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

      # Get the data in the .csv and convert it into a list
      [keys | data] = "#{filename}"
      |> Path.expand()
      |> File.stream!
      |> CSV.decode!
      |> Enum.to_list

      records_list = Enum.map(data, fn(record_data) ->
        Enum.zip(keys, record_data)
        |> Map.new(fn({k, v}) -> {String.to_atom(k), v} end) end)
      Enum.map(records_list, fn(r) -> App.Inventory.create_unit(r) end)
    end)
  end
end
