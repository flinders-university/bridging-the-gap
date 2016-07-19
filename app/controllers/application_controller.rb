class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def mdrender(content)
    content = content
    # Setup a nice pipeline, with some pretty filters...
    pipeline = HTML::Pipeline.new [
      HTML::Pipeline::MarkdownFilter,
      #HTML::Pipeline::SanitizationFilter,
      HTML::Pipeline::ImageMaxWidthFilter,
    ]
    result = pipeline.call(content)
    # Give it back...
    return result[:output].to_s
  end

  def current_user_administrator?
    if current_user.present? && current_user.is_administrator
      true
    else
      false
    end
  end

  def require_administrator!
    if !current_user_administrator?
      redirect_to root_url, notice: "Sorry, your account does not have administrative privileges."
    end
  end

  def notify_slack(message, channel, attachment, color)

    attachments = {
      fallback: "Failed to retrieve details... :frowning:",
      text: "#{attachment}",
      color: "##{color}"
    }

    require 'slack-notifier'

    if channel.present?
      notifier = Slack::Notifier.new ENV["slack-#{channel}"]
    else
      notifier = Slack::Notifier.new ENV["slack-technology"]
    end

    notifier.ping "#{message}", attachments: [attachments]

  end

  helper_method :current_user_administrator?, :mdrender, :notify_slack
end
