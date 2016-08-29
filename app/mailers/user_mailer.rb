class UserMailer < ApplicationMailer
  default from: 'no-reply@bridgingthegap.edu.au'

  # Send this with UserMailer.welcome_email(@user).deliver_later
  def welcome_email(user)
    @user = user
    mail(to: @user.email, subject: 'Welcome to ' + t(:project))
  end
end
