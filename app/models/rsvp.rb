class Rsvp < ApplicationRecord
  validates :full_name, :email, :role, :school, presence: true
  validates :email, uniqueness: true
  validates_format_of :email, :with => Devise::email_regexp
  validates_format_of :full_name, :with => /\s/
end
