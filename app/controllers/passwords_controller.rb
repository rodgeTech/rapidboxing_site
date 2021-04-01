# frozen_string_literal: true

class PasswordsController < Devise::PasswordsController
  include CurrentCart
  before_action :set_cart
end
