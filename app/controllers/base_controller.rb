# frozen_string_literal: true

class BaseController < ApplicationController
  include CurrentCart

  before_action :authenticate_user!
  before_action :set_cart
end
