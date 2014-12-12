json.array!(@flats) do |flat|
  json.extract! flat, :id, :name, :owner
  json.url flat_url(flat, format: :json)
end
