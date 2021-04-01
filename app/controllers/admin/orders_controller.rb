# frozen_string_literal: true

module Admin
  class OrdersController < BaseController
    before_action :order, only: :show

    def index
      @orders = ::Orders::IndexService.call(
        page: params[:page] || 1,
        per: 6,
        status: params[:status],
        date_sort: params[:date],
        query: params[:query]
      )
    end

    def show
      @invoice = @order.invoice
    end

    private

    def order
      @order ||= Order.find(params[:id])
    end
  end
end
