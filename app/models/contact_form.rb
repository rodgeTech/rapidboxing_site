# frozen_string_literal: true

class ContactForm < MailForm::Base
  attribute :name,      validate: true
  attribute :email,     validate: /\A([\w\.%\+\-]+)@([\w\-]+\.)+([\w]{2,})\z/i
  attribute :message

  def headers
    {
      subject: 'New rapidboxing.com contact message',
      to: 'info@rapidboxing.com'
    }
  end
end
