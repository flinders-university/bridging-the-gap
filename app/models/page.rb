class Page < ApplicationRecord
  validates :title, :slug, :author, :public, :group_id, :body, presence: true
  validates :slug, uniqueness: true

  def to_param
    slug
  end
end
