class FocusGroup < ApplicationRecord
  validates :name, :user_id, :start, :slots, presence: true

  belongs_to :user
  has_many :users
end
