# frozen_string_literal: true

module CurrentCart
  private

  def set_cart
    @cart = Cart.find(session[:cart_id])
  rescue ActiveRecord::RecordNotFound
    @cart = Cart.create
    session[:cart_id] = @cart.id
  end

  def set_current_user_cart
    @cart = if current_user.cart.present?
              current_user.cart
            else
              current_user.create_cart
            end
  end
end
