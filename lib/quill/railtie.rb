module Quill
  class Railtie < ::Rails::Railtie #:nodoc:
    initializer 'quill' do |_app|
      Quill::Hooks.init
    end
  end
end