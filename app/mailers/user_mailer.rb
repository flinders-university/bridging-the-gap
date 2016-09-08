class UserMailer < ApplicationMailer
  default from: 'no-reply@bridgingthegap.edu.au'

  # Send this with UserMailer.welcome_email(@user).deliver_later
  def welcome_email(user)
    @user = user
    mail(to: @user.email, subject: 'Welcome to ' + t(:project))
  end

  def focus_group_time(user, focus_group)
    @user = user
    @focus_group = focus_group
    mail(to: @user.addressable, subject: "Focus Group Booking Confirmation")
  end
  
end
