class Form < ApplicationRecord
  belongs_to :group
  has_many :signatures
  has_many :i_surveys
  def title_and_date_required
    self.title + " [required by " + self.date_required.strftime("%-d %B %Y") + "]"
  end
  def group_title_and_date_required
    "(" + self.group.name + ") " + self.title_and_date_required
  end
end
