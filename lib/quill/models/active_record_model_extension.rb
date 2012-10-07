module Quill
  module ActiveRecordModelExtension
    extend ActiveSupport::Concern

    included do

      self.send(:include, Quill::ConfigurationMethods)
      self.send(:include, Quill::CachingMethods)

      # Fetch the values at the selected page
      self.scope Quill.config.page_method_name, Proc.new { |num|
        scope = limit(default_per_page).offset(default_per_page * ([num.to_i, 1].max - 1))

        cache_if_needed(scope, :page => num)

        scope
      } do
        include Quill::PageScopeMethods
      end
    end
  end
end