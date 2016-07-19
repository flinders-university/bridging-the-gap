class Group < ApplicationRecord
  validates :level, :name, :contact, :description, presence: true
  validates :level, uniqueness: true

  has_many :users #, join_table: :users_and_groups

end
