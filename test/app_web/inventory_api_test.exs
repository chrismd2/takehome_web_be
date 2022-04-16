defmodule App.InventoryApiTest do
  use App.DataCase

  alias App.InventoryApi

  test "new/2 creates a new unit" do
    request = %HTTPoison.Request{
      method: :post,
      url: "http://localhost:4002/api/inventory",
      options: [],
      headers: [
        {~s|Content-Type|, ~s|application/json|},
      ],
      params: [],
      body: ~s|{
          "uuid":"value",
          "name":"value",
          "price":"value",
          "category":"value",
          "location_name":"value",
          "location_area":"value"
        }|
    }

    {:ok, response} = HTTPoison.request(request)
    assert response.status_code == 201
  end


  test "import/2 imports the sent file" do
    request = %HTTPoison.Request{
      method: :post,
      url: "http://localhost:4002/api/inventory/import",
      options: [],
      headers: [
        {~s|Content-Type|, ~s|multipart/form-data|},
      ],
      params: [],
      body: {:multipart, [
              {:file, ~s|support/test_data.csv|}
          ]}
    }

    {:ok, response} = HTTPoison.request(request)
    assert response.status_code == 200
  end

  defp get_setup do
    request = %HTTPoison.Request{
      method: :post,
      url: "http://localhost:4002/api/inventory/import",
      options: [],
      headers: [
        {~s|Content-Type|, ~s|multipart/form-data|},
      ],
      params: [],
      body: {:multipart, [
              {:file, ~s|support/test_data.csv|}
          ]}
    }

    {:ok, response} = HTTPoison.request(request)
  end
  defp test_get_helper(params \\ %{}) do
    params = Map.keys(params)
    |> Enum.map(fn(key) ->
      {~s|#{key}|, ~s|#{Map.fetch!(params, key)}|}
    end)

    request = %HTTPoison.Request{
      method: :get,
      url: "http://localhost:4002/api/inventory",
      options: [],
      headers: [],
      params: params,
      body: ""
    }

    {:ok, response} = HTTPoison.request(request)
    response
  end
  test "get/2 gets all the records" do
    response = test_get_helper
    assert response.status_code == 200
  end
  defp value_fixer(value) do
    value = case value do
      "[]" -> []
      _ -> value
    end
  end
  defp map_fix(json_string) do
    a_map = Jason.decode!(json_string)
    Map.keys(a_map)
    |> Enum.map(fn(key) ->
      value = Map.fetch!(a_map, key)
      {status, t_val} = Jason.decode(value)
      if status == :ok do
        {key, value_fixer(t_val) }
      else
        {key, value_fixer(value) }
      end
    end)
    |> Map.new
  end
  test "get/2 gets the records based on provided params" do
    get_setup

    response = test_get_helper(%{"location_area"=>"value"})
    assert response.status_code == 200
    assert map_fix(response.body) == %{"message" => []}

    response = test_get_helper(%{"location_area"=>"test_area_2"})
    assert response.status_code == 200
    list = Jason.decode!(response.body)
    |> Map.fetch!("message")
    |> Jason.decode!()
    [a_map | _tail] = list
    a_map = Jason.decode!(a_map)
    assert is_map(a_map)
    assert Enum.all?(list, fn(unit) ->
      location_area = Jason.decode!(unit)
      |> Map.fetch!("location_area")
      location_area == "test_area_2"
    end)

    response = test_get_helper(%{"location_area"=>"test_area_2","location_name"=>"Location 5"})
    assert response.status_code == 200
    list = Jason.decode!(response.body)
    |> Map.fetch!("message")
    |> Jason.decode!()
    assert Enum.all?(list, fn(unit) ->
      location_area = Jason.decode!(unit)
      |> Map.fetch!("location_area")
      location_name = Jason.decode!(unit)
      |> Map.fetch!("location_name")
      (location_area == "test_area_2" || location_name == "Location 5")
    end)
  end
end
