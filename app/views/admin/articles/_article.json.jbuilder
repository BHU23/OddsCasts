json.extract! article, :id, :title, :description, :cover_url, :created_at, :updated_at
json.url article_url(article, format: :json)
