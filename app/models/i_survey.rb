class ISurvey < ApplicationRecord
  has_many :i_questions
  belongs_to :group
  belongs_to :form

  def name_and_group
   "[" + self.group.name + "] " + self.title
  end
end
