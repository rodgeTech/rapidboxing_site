# frozen_string_literal: true

# Preview all emails at http://localhost:3000/rails/mailers/invoice_mailer
class InvoiceMailerPreview < ActionMailer::Preview
  def new_invoice
    mail = InvoiceMailer.new_invoice(Invoice.last)
    Premailer::Rails::Hook.perform(mail)
  end
end
