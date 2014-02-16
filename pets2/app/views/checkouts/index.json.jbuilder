json.array!(@checkouts) do |checkout|
  json.extract! checkout, :id
  json.url checkout_url(checkout, format: :json)
end
