module Rongcloud
  module Sign

    #生成header数据
    def self.gen_headers
      app_key = Rongcloud.config.app_key
      app_secret = Rongcloud.config.app_secret
      nonce = Rongcloud::Sign.random_str(32)
      time_stamp = Time.now.to_i
      signature = Digest::SHA1.hexdigest("#{app_secret}#{nonce}#{time_stamp}")
      {
          'App-Key' => app_key,
          'Nonce' => nonce,
          'Timestamp' => time_stamp,
          'Signature' => signature
      }
    end

    #生成随机字符串
    def self.random_str(length)
      seed = '0123456789abcdefjhijklmnopqrstuvwxyz'
      length.times.inject('') { |acc, t|
        acc+ seed[Random.rand(seed.length)]
      }
    end
  end
end
