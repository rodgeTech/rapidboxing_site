# frozen_string_literal: true

module Admin
  module Orders
    class ArchivesController < BaseController
      before_action :order, only: %i[show update]

      def index
        @orders = Order.archived
                       .order(created_at: :desc)
                       .page(params[:page])
                       .per(6)
      end

      def show; end

      def update
        @order.update_attributes(archive: false)
        redirect_to admin_order_path(@order)
      end

      private

      def order
        @order ||= Order.find(params[:id])
      end
    end
  end
end
