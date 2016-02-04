require 'active_support/configurable'

module Rongcloud
  class << self
    def configure(&block)
      yield @config ||= Rongcloud::Configuration.new
    end

    def config
      @config
    end
  end

  class Configuration
    include ActiveSupport::Configurable
    config_accessor :app_key, :app_secret, :api_host
  end

  configure do |config|
    config.app_key = ''
    config.app_secret = ''
    config.api_host = 'https://api.cn.rong.io'
  end
end
