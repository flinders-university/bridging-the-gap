json.extract! student_blog, :id, :user_id, :title, :slug, :body, :finished, :created_at, :updated_at
json.url student_blog_url(student_blog, format: :json)