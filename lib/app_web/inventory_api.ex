defmodule AppWeb.InventoryApi do
  use AppWeb, :controller
  import App.Inventory
  def import(conn, params \\ %{}) do
    Map.keys(params)
    |> Enum.map(fn(formname) ->
      params = Map.fetch!(params, formname)
      Mix.Tasks.ImportProducts.run(params.path)
    end)
    |> IO.inspect
    message = "adding new data list"
    conn
    |> put_status(200)
    |> json(%{"message" => message})
  end
  def new(conn, params \\ %{}) do
    {status, changeset} = key_conversion(params)
    |> create_unit
    |> IO.inspect
    case status do
      :ok -> conn
        |> put_status(201)
        |> json(%{"success" => inspect(changeset)})
      :error -> conn
        |> put_status(400)
        |> json(%{"failed to create_unit" => inspect(changeset.errors)})
    end
  end
  def get(conn, %{"id" => id} = _params) do
    message = inspect(get_unit!(id))
    conn
    |> put_status(200)
    |> json(%{"message" => message})
  end
  def get(conn, params \\ %{}) do
    params = key_conversion(params)
    message = list_units
    |> Enum.reject(fn(unit) ->
      Map.keys(params)
      |> Enum.map(fn(k) ->
        (Map.fetch!(params, k) != Map.fetch!(unit, k))
      end)
      |> Enum.all?
    end)
    |> inspect
    conn
    |> put_status(200)
    |> json(%{"message" => message})
  end
  def update(conn, %{"id" => id} = params) do
    {status, changeset} = get_unit!(id)
    |> update_unit(key_conversion(params))
    |> IO.inspect
    case status do
      :ok -> conn
        |> put_status(200)
        |> json(%{"success" => inspect(changeset)})
      :error -> conn
        |> put_status(400)
        |> json(%{"failed to update_unit" => inspect(changeset.errors)})
    end
  end
  def delete(conn, %{"id" => id} = _params) do
    {status, changeset} = get_unit!(id)
    |> delete_unit
    case status do
      :ok ->
        message = "record deleted"
        conn
        |> put_status(200)
        |> json(%{"message" => message})
      :error ->
        message = "record was not deleted: #{inspect(changeset)}"
        conn
        |> put_status(400)
        |> json(%{"message" => message})
    end
  end
  defp new_keys_merge([h | t] = _keys, a_map) do
    new_map = %{String.to_atom(h) => Map.fetch!(a_map, h )}
    if t != [] do
      new_keys_merge(t, a_map)
      |> Map.merge(new_map)
    else
      new_map
    end
  end
  defp key_conversion(a_map) do
    Map.keys(a_map)
    |> new_keys_merge(a_map)
  end
end
