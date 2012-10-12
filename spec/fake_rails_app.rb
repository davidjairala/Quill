# require 'rails/all'
require 'action_controller/railtie'
require 'action_view/railtie'

# config
require 'db/setup'

# Put your acceptance spec helpers inside spec/acceptance/support
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each {|f| require f}

app = Class.new(Rails::Application)
app.config.secret_token = '3b7cd727ee24e8444053437c36cc66c4'
app.config.session_store :cookie_store, :key => '_myapp_session'
app.config.active_support.deprecation = :log

# Rails.root
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
    @users = User.qpage(params[:page])
    render :inline => <<-ERB
<%= @users.map(&:name).join("\n") %>
<%= qpaginate(@users) %>
ERB
  end

  def show
    @user = User.find(params[:id])
    render :inline => <<-ERB
<%= @user.name %>
ERB
  end
end

# helpers
Object.const_set(:ApplicationHelper, Module.new)
