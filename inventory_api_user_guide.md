# Inventory Api User Guide
## Create units
Single unit
```
curl -X POST "localhost:4000/api/inventory" -H "Content-Type: application/json" -d '{
  "uuid":"value",
  "name":"value",
  "price":"value",
  "category":"value",
  "location_name":"value",
  "location_area":"value"
}'
```
Lists of units
```
curl -X POST "localhost:4000/api/inventory/import" -H "Content-Type: multipart/form-data" -F 'file=@data.csv'
```

## Read unit(s)
All unit in database table
```
curl -X GET "localhost:4000/api/inventory"
```
All units with at least one matching parameter
```
curl -X GET "localhost:4000/api/inventory?location_area=value"
```
A specific unit given an ID
```
curl -X GET "localhost:4000/api/inventory?id=f98aedee-0a30-4aa7-b078-a298e6fe79ec"
```

## Update existing units
Modify the parameters of a single unit by passing the id and the parameters you wish to change
```
curl -X PATCH "localhost:4000/api/inventory" -H "Content-Type: application/json" -d '{ "id":"9a8dba3d-0c85-41d6-861c-fdebaed94db4", "location_name":"roof", "location_area":"upper"}'
```
## Delete a specific record
Remove the unit from the data base table if given a valid id
```
curl -X DELETE "localhost:4000/api/inventory" -H "Content-Type: application/json" -d '{ "id":"9a8dba3d-0c85-41d6-861c-fdebaed94db4" }'
```
