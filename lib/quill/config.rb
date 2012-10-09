require 'active_support/all'

module Quill
  # Global settings
  # Quill.configure do |config|
  #   config.default_per_page = 10
  # end
  def self.configure(&block)
    yield @config ||= Quill::Configuration.new
  end

  # Global settings for Quill
  def self.config
    @config
  end

  class Configuration #:nodoc:
    include ActiveSupport::Configurable
    config_accessor :default_per_page
  end

  configure do |config|
    config.default_per_page   = 20
  end
end