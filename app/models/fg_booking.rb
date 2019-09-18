class FgBooking < ApplicationRecord
  belongs_to :user
  validates :user_id, :booking, presence: true
  validates :user_id, uniqueness: true
end
