class UnitPresentation < ApplicationRecord
  belongs_to :user

  has_attached_file :presentation, path: "/btg-project/:class/:id/presentation/:filename", default_url: "/btg-project/:class/:id/missing.pdf", :s3_permissions => :private
  validates_attachment :presentation, content_type: { content_type: ["application/pdf", "application/vnd.openxmlformats-officedocument", "application/msword", "application/vnd.ms-powerpoint"] }

  has_attached_file :notes, path: "/btg-project/:class/:id/notes/:filename", default_url: "/btg-project/:class/:id/missing.pdf", :s3_permissions => :private
  validates_attachment :notes, content_type: { content_type: ["application/pdf", "application/vnd.openxmlformats-officedocument", "application/msword", "application/vnd.ms-powerpoint"] }

  validates :user_id, :title, presence: true
end
