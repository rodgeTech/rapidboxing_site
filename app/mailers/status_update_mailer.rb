# frozen_string_literal: true

class StatusUpdateMailer < ApplicationMailer
  def status_updated(order)
    @order = order
    mail(to: order.email, subject: 'RapidBoxing order status updated')
  end
end
