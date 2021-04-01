# frozen_string_literal: true

class OrderPolicy < ApplicationPolicy
  def index?
    !user.admin?
  end

  def show?
    record.user == user
  end
end
