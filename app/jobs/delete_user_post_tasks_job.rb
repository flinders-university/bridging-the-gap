class DeleteUserPostTasksJob < ApplicationJob
  queue_as :default

  def perform(user)
    ac = ApplicationController.new
    ac.notify_slack("User has cancelled their registration...", "technology", user.addressable, "E36960")
  end
end
