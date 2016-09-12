class CustomDeviseMailer < ApplicationMailer
    default from: "Bridging the Gap <no-reply@bridgingthegap.edu.au>",
            reply_to: 'aidan.cornelius-bell@flinders.edu.au',
            template_path: 'devise/mailer'

    helper :application
    include Devise::Controllers::UrlHelpers

    super
end
