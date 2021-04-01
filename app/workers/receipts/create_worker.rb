# frozen_string_literal: true

module Receipts
  class CreateWorker
    include Sidekiq::Worker

    def perform(deposit_id)
      deposit = Deposit.find(deposit_id)
      ReceiptMailer.deposit_recorded(deposit).deliver
    end
  end
end
