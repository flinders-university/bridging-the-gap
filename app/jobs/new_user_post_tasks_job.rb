class NewUserPostTasksJob < ApplicationJob
  queue_as :default

  def perform(user)
    ac = ApplicationController.new
    ac.notify_slack("New user registration...", "technology", user.addressable, "A3AE4D")
    UserMailer.welcome_email(u).deliver_now
  end
end
