# frozen_string_literal: true

class OrderMailer < ApplicationMailer
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.order_mailer.new_order.subject
  #
  def new_order(order)
    @order = order

    mail to: 'orders@rapidboxing.com', subject: 'You have a new order'
  end
end
