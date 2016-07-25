json.array!(@group_change_requests) do |group_change_request|
  json.extract! group_change_request, :id, :user_id, :group_id
  json.url group_change_request_url(group_change_request, format: :json)
end
