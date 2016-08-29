class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  belongs_to :group #, join_table: :users_and_groups

  belongs_to :industry, optional: true #sometimes...

  after_create :new_user_job_runner

  before_destroy :delete_associated

  has_many :tasks

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

  def new_user_job_runner
	  NewUserPostTasksJob.perform_later(self)
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
