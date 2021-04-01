# frozen_string_literal: true

class PagesController < BaseController
  skip_before_action :authenticate_user!

  def home
    @recommended = Listing.order(created_at: :desc).limit(6)
    @slides = Slide.order(created_at: :desc)
  end

  def shop
    @listings = Listing.order(created_at: :desc)
  end

  def order; end

  def prices; end

  def payment_details; end

  def track_order; end

  def order_status; end

  def about; end

  def policies; end

  def terms_service; end

  def calculator; end
end
