class UserMailer < ApplicationMailer
  default from: "Bridging the Gap <no-reply@bridgingthegap.edu.au>",
          reply_to: 'aidan.cornelius-bell@flinders.edu.au',
          cc: 'aidan.cornelius-bell@flinders.edu.au'

  helper :application

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

  def conference_registration(email, rsvp)
    @rsvp = rsvp
    mail(to: email, subject: "Bridging the Gap Conference Registration")
  end

  def conference_notification(email, rsvp)
    @rsvp = rsvp
    mail(to: email, subject: "Bridging the Gap Conference Resources & Certificate")
  end

  def pst_celebration_sixteen(email, stc)
    @stc = stc
    mail(to: email, subject: "Flinders University Science Preservice Teachers Celebration")
  end

end
