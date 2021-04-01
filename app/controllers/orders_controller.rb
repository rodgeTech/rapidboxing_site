# frozen_string_literal: true

class OrdersController < Dashboard::BaseController
  def index
    @orders = current_user.orders.order(created_at: :desc)
                          .page(params[:page]).per(10)
    authorize @orders
  end

  def show
    @order = Order.find(params[:id])
    authorize @order
  end
end
