# frozen_string_literal: true

module OrderHelper
  def status_classname(current_index, index)
    if current_index == index
      return 'status-current'
    elsif current_index < index
      return 'status-incomplete'
    end

    'status-completed'
  end

  def icon_classname(current_index, index)
    if current_index == index
      return 'far fa-dot-circle mr-1'
    elsif current_index < index
      return 'far fa-circle mr-1'
    end

    'fas fa-check-circle mr-1'
  end
end
