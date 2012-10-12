module Quill
  module PageScopeMethods

    extend ActiveSupport::Concern

    # Determines if there is a next page
    def next_page?
      !!@_q_next_page
    end

    # Next page setter
    def next_page=(val)
      @_q_next_page = val
    end

    # Next page value
    def next_page
      current_page + 1
    end

    # Determines if there is a previous page
    def previous_page?
      !!@_q_previous_page
    end

    # Previous page setter
    def previous_page=(val)
      @_q_previous_page = val
    end

    # Previous page value
    def previous_page
      prev_page = current_page - 1
      return prev_page if prev_page > 0
      0
    end

    # Total number of items in the set
    def total_count(column_name = nil, options = {})
      @total_count ||= begin
        counter = except(:offset, :limit, :order, :includes)
        counter = counter.count(column_name, options)

        total_count = counter.count if counter.is_a?(ActiveSupport::OrderedHash)
        total_count = counter.count(column_name, options) if counter.respond_to?(:count)
        total_count = counter

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

    # Limit of the pagination
    def limit_value
      @_q_limit_value || default_per_page
    end

    # Limit setter
    def limit_value=(val)
      @_q_limit_value = val
    end

    # Offset of the pagination
    def offset_value
      @_q_offset_value || 0
    end

    # Limit setter
    def offset_value=(val)
      @_q_offset_value = val
    end

  end
end
