json.extract! user, :id, :name, :mail, :department, :password_digest, :admin, :created_at, :updated_at
json.url user_url(user, format: :json)
