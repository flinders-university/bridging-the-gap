json.extract! task, :id, :user_id, :title, :description, :when, :visible, :completed, :created_at, :updated_at
json.url task_url(task, format: :json)