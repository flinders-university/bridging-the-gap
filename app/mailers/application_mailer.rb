class ApplicationMailer < ActionMailer::Base
  default from: "Bridging the Gap <no-reply@bridgingthegap.edu.au>",
          reply_to: 'aidan.cornelius-bell@flinders.edu.au'
  layout 'mailer'
end
