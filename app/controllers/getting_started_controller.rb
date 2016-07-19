class GettingStartedController < ApplicationController
  def information
    message = "Message..."
    channel = "general"
    attachment = "Some object"
    color = "6AA3C4"
    notify_slack(message, channel, attachment, color)
  end
end
