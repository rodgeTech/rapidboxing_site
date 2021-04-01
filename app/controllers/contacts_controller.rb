# frozen_string_literal: true

class ContactsController < BaseController
  skip_before_action :authenticate_user!

  def show; end
end
