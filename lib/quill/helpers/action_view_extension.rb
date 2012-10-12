module Quill

  module ActionViewExtension

    def qpaginate(collection)
      render :partial => 'quill/pages', :locals => {:collection => collection}
    end

    def previos_page_link(collection)
      link_to('&laquo; Previous page'.html_safe, url_for(:page => collection.previous_page))
    end

    def next_page_link(collection)
      link_to('Next page &raquo;'.html_safe, url_for(:page => collection.next_page))
    end

  end

end