class Task < ApplicationRecord
  validates :user_id, :title, :description, :when, presence: true
  belongs_to :user
end
