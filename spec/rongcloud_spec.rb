require 'rongcloud'

describe Rongcloud::Service::User do
  it 'get user token test' do
    Rongcloud.app_key = '25wehl3uwrdbw'
    Rongcloud.app_secret = 'MFdJudyld5G'

    user = Rongcloud::Service::User.new

    user.user_id = 1
    user.name = '柳'
    user.portrait_uri = 'http://tp1.sinaimg.cn/1611305952/180/5683416585/1'
    user.get_token

    expect(user.token).to match /.{10,256}/
  end


  it 'pulish private message test' do
    Rongcloud.app_key = '25wehl3uwrdbw'
    Rongcloud.app_secret = 'MFdJudyld5G'

    model = Rongcloud::Service::Message.new

    model.from_user_id = 1
    model.to_user_id = 2
    model.object_name = 'RC:TxtMsg'
    txt_msg = Rongcloud::Service::RCTxtMsg.new
    txt_msg.content = 'hello'
    txt_msg.extra = 'hello extra'

    expect(model.private_publish txt_msg).to eq(true)
  end


end