# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: 'noreply@rapidboxing.com'
  layout 'mailer'
end
