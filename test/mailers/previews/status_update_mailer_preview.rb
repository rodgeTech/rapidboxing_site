# frozen_string_literal: true

# Preview all emails at http://localhost:3000/rails/mailers/status_update_mailer
class StatusUpdateMailerPreview < ActionMailer::Preview
  # Preview this email at http://localhost:3000/rails/mailers/status_update_mailer/status_updated
  def status_updated
    mail = StatusUpdateMailer.status_updated(Order.find(64))
    Premailer::Rails::Hook.perform(mail)
  end
end
