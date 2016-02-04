require 'cgi'
require 'open-uri'
require 'faraday'
require 'json'
require 'base64'
require 'rongcloud/version'
require 'rongcloud/sign'
require 'rongcloud/service'
require 'rongcloud/service/user'
require 'rongcloud/service/message'

module Rongcloud
  class << self
    #API_HOST = 'https://api.cn.rong.io'
    #attr_accessor :app_key
    #attr_accessor :app_secret
    #attr_accessor :api_host

    #def api_host
    #  unless @api_host
    #    return API_HOST
    #  end
    #  @api_host
    #end

    attr_writer :debug_mode

    def debug_mode?
      @debug_mode.nil? ? true : !!@debug_mode
    end

  end
end
