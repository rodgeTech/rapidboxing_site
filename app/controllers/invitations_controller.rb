# frozen_string_literal: true

class InvitationsController < Devise::InvitationsController
  include CurrentCart
  before_action :set_cart
end
