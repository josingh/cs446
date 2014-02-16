json.array!(@animal_items) do |animal_item|
  json.extract! animal_item, :id, :animal_id, :checkout_id
  json.url animal_item_url(animal_item, format: :json)
end
