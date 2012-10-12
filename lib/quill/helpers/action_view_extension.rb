module Quill

  module ActionViewExtension

    def qpaginate(collection)
      render :partial => 'quill/pages', :locals => {:collection => collection}
    end

  end

end