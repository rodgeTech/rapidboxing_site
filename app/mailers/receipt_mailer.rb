# frozen_string_literal: true

class ReceiptMailer < ApplicationMailer
  def deposit_recorded(deposit)
    @deposit = deposit
    @order = deposit.order

    mail(to: @order.email, subject: 'RapidBoxing payment received')
  end
end
