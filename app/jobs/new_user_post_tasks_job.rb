class NewUserPostTasksJob < ApplicationJob
  queue_as :default

  def perform(user)
    ac = ApplicationController.new
    ac.notify_slack("New user registration...", "technology", user.addressable, "A3AE4D")
    um = UserMailer.new
    um.welcome_email(user).deliver_now
  end
end
