json.array!(@todos) do |todo|
  json.extract! todo, :id, :task, :done, :user_id
  json.url todo_url(todo, format: :json)
end
