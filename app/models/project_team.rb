class ProjectTeam < ApplicationRecord
  validates :user_id, :title, :slug, :description, :team, presence: true
  belongs_to :user

  def to_param
    slug
  end
end
