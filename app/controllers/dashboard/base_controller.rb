# frozen_string_literal: true

# Provides a base class for Dashboard controllers to extend
#
# Automatically sets the layout and ensures a regular user is signed in
class Dashboard::BaseController < ApplicationController
  before_action :authenticate_user!

  include CurrentCart
  before_action :set_cart
end
