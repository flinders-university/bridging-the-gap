json.array!(@signatures) do |signature|
  json.extract! signature, :id, :user_id, :form_id, :data
  json.url signature_url(signature, format: :json)
end
