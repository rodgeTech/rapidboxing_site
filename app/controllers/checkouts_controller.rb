# frozen_string_literal: true

class CheckoutsController < BaseController
  skip_before_action :authenticate_user!
  before_action :should_redirect

  layout 'minimal'

  breadcrumb 'Add Link', :new_line_item_path
  breadcrumb 'Cart', :cart_path

  def index; end

  def show; end

  def new
    breadcrumb 'Checkout', new_checkout_path
    breadcrumb 'Payment', '#'
    @order = Order.new
  end

  def create
    @order = Order.new(order_params)

    if @order.valid?
      result = Checkouts::CreateService.call(
        cart: @cart,
        current_user: current_user,
        params: order_params
      )
      # Orders::CreateWorker.perform_async(result.record.id)
      OrdersJob.perform_async(result.record.id)

      redirect_to payment_details_path(checkout_complete: true)
    else
      render :new
    end
  end

  private

  def order_params
    params.require(:order).permit(:email, :contact_number, :name, :address)
  end

  def should_redirect
    redirect_to_back_or_default if @cart.line_items.none?
  end
end
