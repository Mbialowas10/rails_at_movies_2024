json.extract! page, :id, :title, :context, :permalink, :created_at, :updated_at
json.url page_url(page, format: :json)
