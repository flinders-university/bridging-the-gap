class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  belongs_to :group #, join_table: :users_and_groups

  after_create :new_user_job_runner
  before_destroy :delete_user_job_runner

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

  def delete_user_job_runner
    DeleteUserPostTasksJob.perform_later(self)
  end
end
