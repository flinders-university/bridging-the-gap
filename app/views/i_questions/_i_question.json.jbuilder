json.extract! i_question, :id, :survey_id, :type, :description, :grouping_value, :enabled, :comment, :created_at, :updated_at
json.url i_question_url(i_question, format: :json)