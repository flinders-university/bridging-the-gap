class Stc2016 < ApplicationRecord
  validates :name, :degreeyear, :email, presence: true
  validates :email, uniqueness: true

  validates_format_of :email, :with => Devise::email_regexp
  validates_format_of :name, :with => /\s/
end
