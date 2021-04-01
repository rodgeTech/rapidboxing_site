# frozen_string_literal: true

# Provides a base class for Admin controllers to extend
#
# Automatically sets the layout and ensures an administrator is signed in
module Admin
  class BaseController < ApplicationController

    include EnforcesAdminAuthentication

    layout 'admin'
  end
end
