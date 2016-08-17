module Aker
  extend ActiveSupport::Concern

  require 'json'
  require 'active_support'
  require 'active_support/core_ext'
  require 'active_model'

  path = File.expand_path(".", __FILE__)
  Dir[File.dirname(__FILE__) + "/aker/*.rb"].each {|f| require f}

  class << self
    attr_writer :configuration
  end

  def authorize_by(format:)
    class_eval do
      configuration.format = format
      before_action :authorize_by_aker
    end
  end

  def authorize_by_aker
    authorize(format: configuration.format)
  end

  def authorize(format:)
    Tokenizer.new(token: token).decode
  end

  def self.configuration
    Aker::Configuration.config
  end

  def self.configure
    yield(configuration)
  end

  class Configuration
    include ActiveSupport::Configurable

    ## These are the settings specified in the
    ## config/aker.yml
    ## in the apps that use this gem.
    config_accessor :private_key,
                    :version,
                    :format,
                    :algorithm
  end
end
