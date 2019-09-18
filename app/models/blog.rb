class Blog < ApplicationRecord
  validates :title, :slug, :author, :public, :summary, :body, presence: true
  validates :slug, uniqueness: true

  def to_param
    slug
  end
end
