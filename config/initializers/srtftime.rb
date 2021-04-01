# frozen_string_literal: true

module StrftimeOrdinal
  def self.included(base)
    base.class_eval do
      alias_method :old_strftime, :strftime
      def strftime(format)
        old_strftime format.gsub('%o', day.ordinalize)
      end
    end
  end
end

[Time, Date, DateTime].each { |c| c.send :include, StrftimeOrdinal }
