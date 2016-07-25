class Document < ApplicationRecord
  validates :title, :user_id, presence: true
  validates :document, attachment_presence: true
  has_attached_file :document, path: "/btg-project/:class/:id/:style_:filename", default_url: "/btg-project/:class/:id/missing.pdf", :s3_permissions => :private
  validates_attachment :document, content_type: { content_type: ["application/msword", "application/vnd.openxmlformats-officedocument.wordprocessingml.document", "application/vnd.openxmlformats-officedocument.wordprocessingml.template", "application/vnd.ms-word.document.macroEnabled.12", "application/pdf", "application/vnd.openxmlformats-officedocument.presentationml.presentation", "application/postscript", "application/vnd.ms-powerpointtd", "application/vnd.ms-excel", "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet", "application/vnd.ms-excel.sheet.binary.macroEnabled.12", "application/vnd.openxmlformats-officedocument.spreadsheetml.template", "application/xml"] }
  belongs_to :group
  belongs_to :user

  def get_download_path
    self.document.expiring_url(50)
  end
end
