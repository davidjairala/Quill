module Quill
  class Railtie < ::Rails::Railtie
    initializer 'quill' do |_app|
      Quill::Hooks.init
    end
  end
end