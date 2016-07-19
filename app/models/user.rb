class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def is_administrator
    self.administrator
  end

  def name
    self.firstname + " " + self.lastname
  end

  def addressable
    '"' + self.name + '" <' + self.email + '>'
  end
end
