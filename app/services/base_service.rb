# frozen_string_literal: true

class BaseService
  def self.call(*args, &block)
    new(*args, &block).call
  end

  # Generic service result class
  class Result
    attr_reader :record

    def initialize(record:, success:)
      @record = record
      @success = success
    end

    def success?
      @success
    end
  end
end
