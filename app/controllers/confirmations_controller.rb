# frozen_string_literal: true

class ConfirmationsController < Devise::ConfirmationsController
  include CurrentCart
  before_action :set_cart
end
