$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))

require 'rails'
require 'action_controller/railtie'
require 'action_view/railtie'
require 'bundler/setup'
Bundler.require

require 'database_cleaner'
require 'webrat'

require 'fake_rails_app'
require 'rspec/rails'

Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each {|f| require f}

Webrat.configure do |config|
    config.mode = :rails
end