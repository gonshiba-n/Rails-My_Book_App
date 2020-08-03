# Load the Rails application.
require_relative 'application'

# Initialize the Rails application.
Rails.application.initialize!
heroku config | grep SENDGRID