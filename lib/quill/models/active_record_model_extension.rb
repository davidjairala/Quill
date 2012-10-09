module Quill
  module ActiveRecordModelExtension

    extend ActiveSupport::Concern

    included do

      self.send(:include, Quill::ConfigurationMethods)
      self.send(:include, Quill::PageScopeMethods)

    end

    module ClassMethods

      def qpage(num)
        scope = limit(default_big_window).offset(default_per_page * ([num.to_i, 1].max - 1))

        self.next_page      = (scope.size == default_big_window)
        self.previous_page  = (num.to_i > 1)

        scope.limit(default_per_page)
      end

      def next_page?
        !!@_q_next_page
      end

      def next_page=(val)
        @_q_next_page = val
      end

      def previous_page?
        !!@_q_previous_page
      end

      def previous_page=(val)
        @_q_previous_page = val
      end

    end
  end
end