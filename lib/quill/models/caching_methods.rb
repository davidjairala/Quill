module Quill
  module CachingMethods
    extend ActiveSupport::Concern

    module ClassMethods

      # The models' default +cache_page+ value
      def cache_page
        @_default_cache_page ||= Quill.config.cache_page
      end

      # Should we cache the results?
      def caching?
        !!cache_page
      end

      # Construct the cache key
      def cache_key(*args)
        options = args.extract_options!
        page    = options.delete(:page) || 1
        per     = options.delete(:per)  || default_per_page
        
        klass   = self.first.class  if self.is_a?(ActiveRecord::Relation)
        klass   = self              if self.is_a?(Class)
        klass   ||= self.class

        "q_#{klass.table_name}_#{page}_#{per}"
      end

      # Set the cache if needed
      def cache_if_needed(*args)
        if caching?
          options = args.extract_options!
          results   = args.first

          key = cache_key(results, options)
          Rails.cache.write(key, results)
          key
        end
      end

      # Set total count if needed
      def cache_count_if_needed(count)
        if caching?
          key = "#{cache_key(klass)}_count"
          Rails.cache.write(key, count)
          key
        end
      end
    end
  end
end