json.array!(@bills) do |bill|
  json.extract! bill, :id, :value, :user_id, :market_id
  json.url bill_url(bill, format: :json)
end
