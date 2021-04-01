# frozen_string_literal: true

module Admin
  class ListingsController < BaseController
    before_action :listing, only: %i[edit update destroy]

    def index
      @listings = Listing.order(created_at: :desc).page(params[:page]).per(5)
    end

    def new
      @listing = Listing.new
    end

    def create
      @listing = Listing.new(listing_params)
      if @listing.save
        save_images if params[:listing][:images]
        flash[:success] = 'Listing created successfully'
        redirect_to admin_listings_path
      else
        render :new
      end
    end

    def edit; end

    def update
      if @listing.update_attributes(listing_params)
        update_images if params[:listing][:images]
        flash[:success] = 'Listing updated successfully'
        redirect_to admin_listings_path
      else
        render :edit
      end
    end

    def destroy
      @listing.destroy
      flash[:success] = 'Listing removed successfully'
      redirect_to admin_listings_path
    end

    private

    def listing_params
      params.require(:listing).permit(:title, :description, :shipping_rate_id,
                                      :requirements, :link, :price)
    end

    def listing
      @listing ||= Listing.friendly.find_by_slug!(params[:id])
    end

    def save_images
      params[:listing][:images].each do |image|
        @listing.images.create!(image: image)
      end
    end

    def update_images
      params[:listing][:images].each do |image|
        @listing.images.create!(image: image)
      end
    end
  end
end
