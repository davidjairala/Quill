$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))

require 'rails'
require 'action_controller/railtie'
require 'action_view/railtie'
require 'bundler/setup'
Bundler.require

require 'database_cleaner'

Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each {|f| require f}

RSpec.configure do |config|
  config.mock_with :mocha
end

require 'db/setup'

app = Class.new(Rails::Application)
app.config.secret_token = 'bc4cf2645e7bb4b207197cde383e2c20'
app.config.session_store :cookie_store, :key => '_quill_test_session'
app.config.active_support.deprecation = :log
app.config.root = File.dirname(__FILE__)
Rails.backtrace_cleaner.remove_silencers!
app.initialize!

# routes
app.routes.draw do
  resources :users
end

# controllers
class ApplicationController < ActionController::Base; end
class UsersController < ApplicationController
  def index
    @users = User.page params[:page]
    render :inline => <<-ERB
<%= @users.map(&:name).join("\n") %>
<%= paginate @users %>
ERB
  end
end