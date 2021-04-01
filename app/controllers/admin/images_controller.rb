# frozen_string_literal: true

module Admin
  class ImagesController < BaseController
    def destroy
      Image.find(params[:id]).destroy
      redirect_to edit_admin_listing_path(params[:listing_id]),
                  flash: { success: 'Image removed successfully' }
    end
  end
end
