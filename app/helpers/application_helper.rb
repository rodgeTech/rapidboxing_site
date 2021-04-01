# frozen_string_literal: true

module ApplicationHelper
  def bootstrap_class_for_flash(flash_type)
    case flash_type
    when 'success'
      'alert-success'
    when 'error'
      'alert-danger'
    when 'alert'
      'alert-warning'
    when 'notice'
      'alert-primary'
    when 'info'
      'alert-primary'
    else
      flash_type.to_s
    end
  end

  def dashboard_link
    path = current_user.admin? ? admin_root_path : dashboard_path
    link_to 'Dashboard', path, class: 'btn btn-primary bg-primary-linear'
  end

  def departure_arrival_class(date, schedule)
    class_name = ''
    class_name = 'departure' if date == schedule.departure
    class_name = 'arrival' if date == schedule.arrival
    class_name
  end

  def home_link
    if current_user
      return admin_root_path if current_user.admin?

      return root_path
    end
    root_path
  end

  def order_status(status)
    status.split('_').collect(&:capitalize).join(' ')
  end

  def format_date_time(date_time)
    date_time.strftime('%B %d, %Y %l:%M %p')
  end

  def current_page_params
    # Whitelist url params for linking to the current page
    request.params.slice('date', 'status')
  end

  def shipping_rate_type(short_rate_type)
    return 'WeightShippingRate' if short_rate_type.downcase == 'Weight'

    'PriceShippingRate'
  end
end
