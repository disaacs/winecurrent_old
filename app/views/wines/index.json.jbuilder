json.array!(@wines) do |wine|
  json.extract! wine, :name
  json.url wine_url(wine, format: :json)
end
