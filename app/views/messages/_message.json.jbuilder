json.extract! message, :id, :body, :author_hash_ip, :created_at, :updated_at
json.url message_url(message, format: :json)
