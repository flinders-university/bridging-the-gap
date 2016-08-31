class StudentGroup < ApplicationRecord
  has_many :users
  has_many :research_scientists

  def id_and_count
    self.id.to_s + " [" + self.users.count.to_s + " Members]"
  end
end
