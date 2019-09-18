class StudentBlog < ApplicationRecord
  belongs_to :user

  validates :slug, presence: true, uniqueness: true

  validates :title, :body, presence: true

  def to_param
    slug
  end
end
