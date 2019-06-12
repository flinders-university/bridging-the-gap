class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable, :masqueradable, :omniauthable

  belongs_to :group #, join_table: :users_and_groups

  belongs_to :industry, optional: true #sometimes...

  belongs_to :student_group, optional: true #sometimes (if student, if accepted)

  belongs_to :focus_group, optional: true

  after_create :new_user_job_runner

  before_destroy :delete_associated

  has_many :tasks

  has_many :research_scientists

  def setplacement(industry_id)
    self.industry_id = industry_id
    industry = Industry.find_by_id(industry_id)
    SendPlacementDetailsJob.perform_later(self, industry)
    self.save
  end

  def setgroup(group_id)
    self.group_id = group_id
    self.save
  end

  def is_administrator
    self.administrator
  end

  def name
    self.firstname + " " + self.lastname
  end

  def addressable
    '"' + self.name + '" <' + self.email + '>'
  end

  def name_and_email
    self.name + " " + self.email
  end


  def new_user_job_runner
	  NewUserPostTasksJob.perform_later(self)
    UserMailer.welcome_email(self).deliver_now
  end

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      Rails.logger.fatal("Request response from MS AD required info: SN: #{auth.info.first_name} FN: #{auth.info.last_name} EM: #{auth.info.email}")
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      user.firstname = auth.info.first_name   # assuming the user model has a name
      user.lastname = auth.info.last_name
      # user.image = auth.info.image # assuming the user model has an image
      # If you are using confirmable and the provider(s) you use validate emails,
      # uncomment the line below to skip the confirmation emails.
      user.skip_confirmation!
      user.save
    end
  end

  private
  def delete_associated
    a = Answer.where(user_id: self.id)
    a.each do |ans|; ans.destroy; end
    i = Industry.where(user_id: self.id)
    i.each do |ind|; ind.destroy; end
    s = Signature.where(user_id: self.id)
    s.each do |sig|; sig.destroy; end
    g = GroupChangeRequest.where(user_id: self.id)
    g.each do |gcr|; gcr.destroy; end

    DeleteUserPostTasksJob.perform_later(self)
  end
end
