class ApplicationMailer < ActionMailer::Base
  default from: Rails.application.secrets.mailer[:address]
  layout 'mailer'
end
