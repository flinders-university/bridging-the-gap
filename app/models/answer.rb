class Answer < ApplicationRecord
  #Not using relations for this table (we can debug the answers more easily in post)
  validates :user_id, :survey_id, :group_id, :question_id, :answer, presence: true
end
