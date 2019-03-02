json.extract! comment, :id, :body, :author_hash_ip, :created_at, :updated_at
json.url comment_url(comment, format: :json)
