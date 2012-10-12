module Quill
  module ActiveRecordModelExtension

    extend ActiveSupport::Concern

    included do

      self.send(:include, Quill::ConfigurationMethods)

    end

    module ClassMethods

      def qpage(num)
        offset_value    = default_per_page * ([num.to_i, 1].max - 1)
        previous_page   = (num.to_i > 1)
        limit_value     = default_per_page
        offset_value    = offset_value

        scope = limit(default_big_window).offset(offset_value)

        # set next page if available
        next_page = (scope.size == default_big_window)

        scope = scope.except(:limit).limit(default_per_page)

        scope.extend Quill::PageScopeMethods

        scope.previous_page  = previous_page
        scope.limit_value    = limit_value
        scope.offset_value   = offset_value
        scope.next_page      = next_page

        return scope
      end

    end
  end
end