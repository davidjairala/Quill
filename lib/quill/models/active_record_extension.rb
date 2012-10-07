module Quill
  module ActiveRecordExtension
    extend ActiveSupport::Concern

    included do

      # Inherit Quill into future subclasses
      class << self
        def inherited_with_quill(klass) #:nodoc:
          inherited_without_quill(klass)
          klass.send(:include, Quill::ActiveRecordModelExtension) if klass.superclass == ActiveRecord::Base
        end
        alias_method_chain :inherited, :quill
      end

      self.descendants.each do |klass|
        klass.send(:include, Quill::ActiveRecordModelExtension) if klass.superclass == ActiveRecord::Base
      end

    end
  end
end