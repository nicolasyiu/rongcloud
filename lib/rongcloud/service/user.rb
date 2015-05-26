module Rongcloud
  module Service
    class User < Rongcloud::Service::Model
      attr_accessor :user_id
      attr_accessor :name
      attr_accessor :portrait_uri
      attr_accessor :token

      #获取用户的token
      def get_token
        post = {uri: Rongcloud::Service::API_URI[:USER_GET_TOKEN],
                params: optional_params({userId: self.user_id, name: self.name, portraitUri: self.portrait_uri})
        }
        res = Rongcloud::Service.req_post(post)
        self.token = res[:token]
        res[:token]
      end

      #刷新用户信息
      def refresh
        post = {uri: Rongcloud::Service::API_URI[:USER_REFRESH],
                params: optional_params({userId: self.user_id, name: self.name, portraitUri: self.portrait_uri})
        }
        res = Rongcloud::Service.req_post(post)
        res[:code]==200
      end
    end
  end
end