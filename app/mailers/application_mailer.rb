class ApplicationMailer < ActionMailer::Base
  default from: 'info@heroku.com'
  layout 'mailer'
end
