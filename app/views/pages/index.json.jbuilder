json.array!(@pages) do |page|
  json.extract! page, :id, :title, :slug, :author, :public, :group_id, :body
  json.url page_url(page, format: :json)
end
