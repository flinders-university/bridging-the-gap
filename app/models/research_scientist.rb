class ResearchScientist < ApplicationRecord
  belongs_to :user
  belongs_to :student_group

  validates :public_email, presence: true, uniqueness: true
end
