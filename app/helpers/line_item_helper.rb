# frozen_string_literal: true

module LineItemHelper
  def new_li_title(listing = nil)
    listing ? listing.title : 'Add link item to cart'
  end

  def new_li_requirements_info(listing = nil)
    if listing
      tag.p class: 'text-info' do
        listing.requirements
      end
    end
  end
end
