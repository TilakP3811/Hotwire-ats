class ApplicationMailer < ActionMailer::Base
  routing /reply/i => :applicant_replies

  default from: "from@example.com"
  layout "mailer"
end
