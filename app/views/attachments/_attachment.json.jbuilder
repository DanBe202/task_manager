json.extract! attachment, :id, :filename, :url, :task_id, :created_at, :updated_at
json.url attachment_url(attachment, format: :json)
