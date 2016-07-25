class Form < ApplicationRecord
  belongs_to :group
  has_many :signatures
  def title_and_date_required
    self.title + " [required by " + self.date_required.strftime("%-d %B %Y") + "]"
  end
end
