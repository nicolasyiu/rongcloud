module Rongcloud
  module Service
    class GroupUserGag < Rongcloud::Service::Model
      attr_accessor :user_id
      attr_accessor :group_id
      attr_accessor :minute

      def add
        post = {uri: Rongcloud::Service::API_URI[:GROUP_USER_GAG_ADD],
                params: optional_params({userId: self.user_id,
                                         groupId: self.group_id,
                                         minute: self.minute})
        }
        res = Rongcloud::Service.req_post(post)
        res[:code]==200
      end

      def rollback
        post = {uri: Rongcloud::Service::API_URI[:GROUP_USER_GAG_ROLLBACK],
                params: optional_params({userId: self.user_id,
                                         groupId: self.group_id})
        }
        res = Rongcloud::Service.req_post(post)
        res[:code]==200
      end

      def list
        post = {uri: Rongcloud::Service::API_URI[:GROUP_USER_GAG_LIST],
                params: optional_params({groupId: self.group_id})
        }
        res = Rongcloud::Service.req_post(post)
        res[:code]==200
      end

    end
  end
end


