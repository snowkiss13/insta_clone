json.extract! contact, :id, :name, :email, :content, :created_at, :updated_at
json.url contact_url(contact, format: :json)
