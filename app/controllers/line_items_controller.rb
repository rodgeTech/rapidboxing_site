# frozen_string_literal: true

class LineItemsController < BaseController
  skip_before_action :authenticate_user!
  before_action :set_cart
  before_action :line_item, only: %i[destroy edit update]
  before_action :listing, only: %i[new create]

  def new
    @line_item = LineItem.new
  end

  def create
    @line_item = LineItem.new(line_item_params)
    @line_item.cart = @cart
    @line_item.listing = @listing if @listing.present?
    if @line_item.save
      redirect_to cart_path
    else
      render :new
    end
  end

  def update
    if @line_item.update_attributes(line_item_params)
      redirect_to cart_path
    else
      redirect_to cart_path,
                  flash: { alert: 'Item could not be updated' }
    end
  end

  def destroy
    @line_item.destroy
    redirect_to cart_path
  end

  private

  def line_item_params
    params.require(:line_item).permit(:details, :quantity, :link,
                                      :shipping_rate_id, :extra_pounds,
                                      :price, :local_pickup)
  end

  def line_item
    @line_item ||= LineItem.find(params[:id])
  end

  def listing
    return unless params[:listing_id]

    @listing ||= Listing.friendly.find(params[:listing_id])
  end
end
