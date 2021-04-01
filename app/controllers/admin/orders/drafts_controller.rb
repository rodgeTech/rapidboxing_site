# frozen_string_literal: true

module Admin
  module Orders
    class DraftsController < BaseController
      def index
        @orders = Order.where(draft: true)
                       .order(created_at: :desc)
                       .page(params[:page])
                       .per(6)
      end

      def show; end
    end
  end
end
