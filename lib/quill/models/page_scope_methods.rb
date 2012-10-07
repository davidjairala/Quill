module Quill
  module PageScopeMethods
    # Total number of items in the set
    def total_count(column_name = nil, options = {})
      @total_count ||= begin
        counter = except(:offset, :limit, :order, :includes)
        counter = counter.count(column_name, options)

        return counter.count if counter.is_a?(ActiveSupport::OrderedHash)
        return counter.count(column_name, options) if counter.respond_to?(:count)
        counter
      end
    end

    # Specify the <tt>per_page</tt> value for the preceding <tt>page</tt> scope
    #   Model.page(3).per(10)
    def per(num)
      return self if (n = num.to_i) <= 0
      limit(n).offset(offset_value / limit_value * n)
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

    # Big window
    def big_window
      default_per_page + 1
    end

    # Determines if there is a next page
    def next_page?
      @next_page ||= except(:order, :includes).
                      limit(1).
                      offset((big_window * ([current_page.to_i, 1].max - 1)) + default_per_page).
                      any?

      @next_page
    end

    # Determines if there is a previous page
    def previous_page?
      current_page > 1
    end
  end
end
