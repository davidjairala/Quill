module Quill
  class Hooks
    def self.init
      ActiveSupport.on_load(:active_record) do
        require 'quill/models/active_record_extension'
        ::ActiveRecord::Base.send :include, Quill::ActiveRecordExtension
      end

      ActiveSupport.on_load(:action_view) do
        ::ActionView::Base.send :include, Quill::ActionViewExtension
      end
    end
  end
end