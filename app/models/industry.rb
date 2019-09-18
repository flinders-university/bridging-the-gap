class Industry < ApplicationRecord
  belongs_to :user
  has_many :users
  validates :user_id, :name, presence: true
  validates :name, :email, presence: true, uniqueness: true
end
