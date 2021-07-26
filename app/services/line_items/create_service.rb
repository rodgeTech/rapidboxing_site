# frozen_string_literal: true

module LineItems
  class CreateService < BaseService
    def initialize(cart:, params:, images:)
      @cart = cart
      @params = params
      @images = images
    end

    def call
      create_line_item
    end

    def create_line_item
      byebug
      line_item = @cart.line_items.find_by_link(@params[:link])

      if line_item
        line_item.increment!(:quantity)
        Result.new(record: line_item, success: true)
      else
        line_item = @cart.line_items.new(@params)
        if line_item.save!
          save_images(line_item) unless @images.nil?
          Result.new(record: line_item, success: true)
        else
          Result.new(record: line_item, success: false)
        end
      end
    end

    def save_images(line_item)
      byebug
      @images.each do |image|
        line_item.images.create!(image: image)
      end
    end
  end
end
