class IQuestion < ApplicationRecord
  belongs_to :i_survey
  validates :i_survey_id, :input_type, :description, :grouping_value, :order, presence: true
end
