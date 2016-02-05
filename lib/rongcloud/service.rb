module Rongcloud
  module Service

    API_URI = {
        USER_GET_TOKEN: '/user/getToken.json',
        USER_REFRESH: '/user/refresh.json',
        MSG_PRV_PUBLISH: '/message/private/publish.json',
        MSG_HISTORY: '/message/history.json'
    }

    def self.req_get(config)

      config = default_request_config(config)

      conn = Faraday.new(:url => config[:host])
      response = conn.get do |req|
        req.url config[:uri]
        config[:headers].each { |key, value| req.headers[key.to_s] = value.to_s }
        config[:params] && config[:params].each { |key, value| req.params[key.to_s] = value.to_s }
      end

      response_body = response.body
      warn("get response #{response_body}")
      res_data(response_body)
    end

    def self.req_post(config, post_format='urlencode')

      config = default_request_config(config)

      conn = Faraday.new(:url => config[:host])
      response = conn.post do |req|
        req.url config[:uri]
        config[:headers].each { |key, value| req.headers[key.to_s] = value.to_s }
        if post_format.to_s == 'urlencode'
          req.headers['Content-Type'] = 'application/x-www-form-urlencoded'
          req.body = config[:params].collect { |key, value| "#{key}=#{value}" }.join('&')
        elsif post_format.to_s == 'json'
          req.headers['Content-Type'] = 'application/json'
          req.body = config[:params].to_json
        end
        warn("post #{req.body}")
      end

      response_body = response.body
      warn("post response #{response_body}")
      res_data(response_body)
    end

    def self.res_data(response_body)
      sym_keyed_hash(JSON.parse(response_body))
    end

    #返回key为sym的hash
    def self.sym_keyed_hash(hash)
      hash.inject({}) { |memo, (key, v)| memo[key.to_sym]=v; memo }
    end

    def self.default_request_config(config)
      config[:host] ||= Rongcloud.config.api_host
      config[:uri] ||= nil
      config[:params] ||= {}
      config[:headers] ||= Rongcloud::Sign.gen_headers
      config
    end

    # 所有数据类的父类
    class Model
      private
      #返回可选参数（为空的参数不返回）
      def optional_params(params)
        params.select { |key, v| v }
      end
    end
  end
end
