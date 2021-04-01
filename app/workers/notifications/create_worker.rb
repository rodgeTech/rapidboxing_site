# frozen_string_literal: true

module Notifications
  class CreateWorker
    include Sidekiq::Worker

    def perform(type, user_id)
      OneSignalService.call(type, user_id)
    end
  end
end
