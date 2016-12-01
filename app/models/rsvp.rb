class Rsvp < ApplicationRecord
  validates :full_name, :email, :role, :school, presence: true
  validates :email, uniqueness: true
  validates_format_of :email, :with => Devise::email_regexp
  validates_format_of :full_name, :with => /\s/

  def self.to_csv
  attributes = %w{id full_name email role school year_level for_full_name for_email attending_too}

  CSV.generate(headers: true) do |csv|
    csv << attributes

    all.each do |user|
      csv << attributes.map{ |attr| user.send(attr) }
    end
  end
end
end
