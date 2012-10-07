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
    config_accessor :page_method_name
    config_accessor :cache_page
    config_accessor :cache_expires_in

    def param_name
      config.param_name.respond_to?(:call) ? config.param_name.call : config.param_name
    end

    # define param_name writer (copied from AS::Configurable)
    writer, line = 'def param_name=(value); config.param_name = value; end', __LINE__
    singleton_class.class_eval writer, __FILE__, line
    class_eval writer, __FILE__, line
  end

  configure do |config|
    config.default_per_page   = 20
    config.page_method_name   = :page
    config.param_name         = :page
    config.cache_page         = true
    config.cache_expires_in   = 1.hour
  end
end