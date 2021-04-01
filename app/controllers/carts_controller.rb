# frozen_string_literal: true

class CartsController < BaseController
  skip_before_action :authenticate_user!

  def show
    @line_items = @cart.line_items.order(created_at: :desc)
  end
end
