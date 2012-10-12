module Quill
  class Engine < ::Rails::Engine
    initializer 'quill' do |_app|
      Quill::Hooks.init
    end
  end
end