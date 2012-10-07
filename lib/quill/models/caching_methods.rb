module Quill
  module CachingMethods
    extend ActiveSupport::Concern

    module ClassMethods

      # Cache TTL
      def expires_in
        @_default_expires_in ||= Quill.config.cache_expires_in
      end

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

        "q_#{self.table_name}_#{page}_#{per}"
      end

      # Set the cache if needed
      def cache_if_needed(*args)
        if caching?
          options = args.extract_options!
          results   = args.first

          key = cache_key(results, options)
          Rails.cache.write(key, results, :time_to_live => expires_in)
          key
        end
      end

      # Set total count if needed
      def cache_count_if_needed(count)
        if caching?
          key = "#{cache_key(klass)}_count"
          Rails.cache.write(key, count, :time_to_live => expires_in)
          key
        end
      end
    end
  end
end