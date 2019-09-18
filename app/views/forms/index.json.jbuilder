json.array!(@forms) do |form|
  json.extract! form, :id, :title, :group_id, :description, :body, :date_required
  json.url form_url(form, format: :json)
end
