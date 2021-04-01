# frozen_string_literal: true

# Preview all emails at http://localhost:3000/rails/mailers/order_mailer
class OrderMailerPreview < ActionMailer::Preview
  # Preview this email at http://localhost:3000/rails/mailers/order_mailer/new_order
  def new_order
    mail = OrderMailer.new_order(Order.find(64))
    Premailer::Rails::Hook.perform(mail)
  end
end
