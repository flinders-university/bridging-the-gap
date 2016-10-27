class IndustryPresentation < ApplicationRecord

  belongs_to :industry
  belongs_to :user

  has_attached_file :presentation, path: "/btg-project/:class/:id/presentation/:filename", default_url: "/btg-project/:class/:id/missing.pdf", :s3_permissions => :private
  validates_attachment :presentation, content_type: { content_type: ["application/pdf", "application/vnd.openxmlformats-officedocument", "application/msword", "application/vnd.ms-powerpoint"] }

  has_attached_file :script, path: "/btg-project/:class/:id/script/:filename", default_url: "/btg-project/:class/:id/missing.pdf", :s3_permissions => :private
  validates_attachment :script, content_type: { content_type: ["application/pdf", "application/vnd.openxmlformats-officedocument", "application/msword", "application/vnd.ms-powerpoint"] }

  validates :industry_id, :title, :description, presence: true

end
