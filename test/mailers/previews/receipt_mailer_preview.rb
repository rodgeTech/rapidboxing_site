# frozen_string_literal: true

# Preview all emails at http://localhost:3000/rails/mailers/receipt_mailer
class ReceiptMailerPreview < ActionMailer::Preview
  def deposit_recorded
    mail = ReceiptMailer.deposit_recorded(Deposit.last)
    Premailer::Rails::Hook.perform(mail)
  end
end
