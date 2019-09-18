json.extract! student_group, :id, :confirmed, :finalised, :created_at, :updated_at
json.url student_group_url(student_group, format: :json)