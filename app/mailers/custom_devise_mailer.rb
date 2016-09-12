require 'digest/sha2'
class CustomDeviseMailer < Devise::Mailer
    default from: "Bridging the Gap <no-reply@bridgingthegap.edu.au>",
            reply_to: 'aidan.cornelius-bell@flinders.edu.au',
            template_path: 'devise/mailer',
            "Message-ID" => "#{Digest::SHA2.hexdigest(Time.now.to_i.to_s)}@bridgingthegap.edu.au"

    helper :application
    include Devise::Controllers::UrlHelpers
end
