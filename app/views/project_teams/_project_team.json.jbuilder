json.extract! project_team, :id, :user_id, :title, :slug, :description, :team, :enabled, :created_at, :updated_at
json.url project_team_url(project_team, format: :json)