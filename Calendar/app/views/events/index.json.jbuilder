json.array!(@events) do |event|
  json.extract! event, :id, :title, :description, :date, :startTime, :endTime
  json.url event_url(event, format: :json)
end
