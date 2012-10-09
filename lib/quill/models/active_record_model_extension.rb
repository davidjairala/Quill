module Quill
  module ActiveRecordModelExtension

    extend ActiveSupport::Concern

    included do

      self.send(:include, Quill::ConfigurationMethods)
      self.send(:include, Quill::PageScopeMethods)

    end

    module ClassMethods

      def qpage(num)
        self.previous_page  = (num.to_i > 1)
        self.limit_value    = default_per_page
        self.offset_value   = self.limit_value * ([num.to_i, 1].max - 1)

        scope = limit(default_big_window).offset(self.offset_value)

        self.next_page      = (scope.size == default_big_window)

        scope.limit(default_per_page)
      end

    end
  end
end