# frozen_string_literal: true

module LineItems
  class CreateService < BaseService
    def initialize(cart:, params:)
      @cart = cart
      @params = params
    end

    def call
      create_line_item
    end

    def create_line_item
      line_item = @cart.line_items.find_by_link(@params[:link])

      if line_item
        line_item.increment!(:quantity)
        Result.new(record: line_item, success: true)
      else
        line_item = @cart.line_items.new(@params)
        if line_item.save!
          Result.new(record: line_item, success: true)
        else
          Result.new(record: line_item, success: false)
        end
      end
    end
  end
end
