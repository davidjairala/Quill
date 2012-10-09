module Quill
  module PageScopeMethods

    # Total number of items in the set
    def total_count(column_name = nil, options = {})
      @total_count ||= begin
        counter = except(:offset, :limit, :order, :includes)
        counter = counter.count(column_name, options)

        total_count = counter.count if counter.is_a?(ActiveSupport::OrderedHash)
        total_count = counter.count(column_name, options) if counter.respond_to?(:count)
        total_count = counter

        cache_total_count_if_needed(total_count)

        total_count
      end
    end

    # Total number of pages
    def total_pages
      (total_count.to_f / limit_value).ceil
    end

    # Current page number
    def current_page
      (offset_value / limit_value) + 1
    end

    # First page of the collection ?
    def first_page?
      current_page == 1
    end

    # Last page of the collection?
    def last_page?
      current_page >= total_pages
    end

  end
end
