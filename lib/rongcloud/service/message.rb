module Rongcloud
  module Service
    class Message < Rongcloud::Service::Model
      attr_accessor :from_user_id
      attr_accessor :to_user_id
      attr_accessor :object_name #消息类型

      def private_publish(rc_msg)
        post = {uri: Rongcloud::Service::API_URI[:MSG_PRV_PUBLISH],
                params: optional_params({fromUserId: self.from_user_id, toUserId: self.to_user_id,
                                         objectName: self.object_name,
                                         content: rc_msg.json_content})
        }
        res = Rongcloud::Service.req_post(post)
        res[:code]==200
      end
    end
    # 不同类型的消息
    class RCMsg < Rongcloud::Service::Model
      attr_accessor :content
      attr_accessor :extra

      def necessary_attrs
      end

      def json_content
        necessary_attrs.to_json
      end
    end

    class RCTxtMsg< Rongcloud::Service::RCMsg
      def necessary_attrs
        {content: self.content, extra: self.extra}
      end
    end

    class RCImgMsg< Rongcloud::Service::RCMsg
      attr_accessor :image_uri

      def necessary_attrs
        {content: self.content, imageUri: self.image_uri}
      end
    end

    class RCVcMsg< Rongcloud::Service::RCMsg
      attr_accessor :duration

      def necessary_attrs
        {content: self.content, duration: self.duration, extra: self.extra}
      end
    end

    class RCImgTextMsg< Rongcloud::Service::RCMsg
      attr_accessor :title
      attr_accessor :image_uri

      def necessary_attrs
        {title: self.title, content: self.content, imageUri: self.image_uri, extra: self.extra}
      end
    end

    class RCLBSMsg< Rongcloud::Service::RCMsg
      attr_accessor :latitude
      attr_accessor :longitude
      attr_accessor :poi

      def necessary_attrs
        {content: self.content, latitude: self.latitude, longitude: self.longitude, poi: self.poi, extra: self.extra}
      end
    end

    class RCContactNtf< Rongcloud::Service::RCMsg
      attr_accessor :operation
      attr_accessor :source_user_id
      attr_accessor :target_user_id
      attr_accessor :message

      def necessary_attrs
        {operation: self.operation, sourceUserId: self.source_user_id, targetUserId: self.target_user_id, message: self.message, extra: self.extra}
      end
    end
  end
end