# frozen_string_literal: true

require 'httparty'

class OneSignalService
  attr_reader :title
  attr_reader :message
  attr_reader :user_id

  API_URL = 'https://onesignal.com/api/v1/notifications'
  APP_ID = '6f706d0f-df46-4e62-bf8b-122adc18ba9b'
  HEADERS = {
    'Authorization' => 'Basic MWMwNjUwM2UtODQ1NC00Yjk0LTg3ZDQtMmFiNjU1ZTdmMDdm',
    'Content-Type' => 'application/json'
  }.freeze

  @body = {
    'app_id' => APP_ID
  }

  def initialize(type, user_id)
    @title = I18n.t :title, scope: [:notifications, type]
    @message = I18n.t :message, scope: [:notifications, type]
    @user_id = user_id
  end

  def self.call(*args, &block)
    new(*args, &block).push_notification
  end

  def push(body)
    HTTParty.post(
      API_URL,
      headers: HEADERS,
      body: body
    )
  end

  def push_notification
    notification = {
      app_id: APP_ID,
      headings: { en: title },
      contents: { en: message },
      include_external_user_ids: [user_id]
    }.to_json
    push(notification)
  end
end
