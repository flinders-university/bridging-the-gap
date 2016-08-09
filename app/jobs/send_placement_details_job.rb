class SendPlacementDetailsJob < ApplicationJob
  queue_as :default

  def perform(*args)
    ac = ApplicationController.new
    ac.notify_slack("User was placed...", "technology", user.addressable + " in " + industry.name, "A3AE4D")
    
  end
end
