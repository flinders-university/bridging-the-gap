require 'digest/sha2'
class ApplicationMailer < ActionMailer::Base
  default from: "Bridging the Gap <no-reply@bridgingthegap.edu.au>",
          reply_to: 'aidan.cornelius-bell@flinders.edu.au',
          "Message-ID" => "#{Digest::SHA2.hexdigest(Time.now.to_i.to_s)}@bridgingthegap.edu.au"
  layout 'mailer'
end
