require 'spec_helper'

describe Rongcloud::Service::User do
  before(:all) do
    CONFIG = YAML.load(File.open(Rongcloud.root+ '/config.yml')).symbolize_keys
    @config = CONFIG[:rongcloud].symbolize_keys
    Rongcloud.configure do |config|
      config.app_key = @config[:app_key]
      config.app_secret = @config[:app_secret]
      config.api_host = @config[:api_host]
    end
  end

  it 'get user token test' do
    #Rongcloud.app_key = 'YOUR_SECRET'
    #Rongcloud.app_secret = 'YOUR_SECRET'

    user = Rongcloud::Service::User.new

    user.user_id = 2
    user.name = '柳溪'
    user.portrait_uri = 'http://tp1.sinaimg.cn/1611305952/180/5683416585/1'
    user.get_token

    expect(user.token).to match /.{10,256}/
  end


  it 'update user info test' do
    #Rongcloud.app_key = 'YOUR_SECRET'
    #Rongcloud.app_secret = 'YOUR_SECRET'

    user = Rongcloud::Service::User.new

    user.user_id = 2
    user.name = '柳溪XXXX'
    user.portrait_uri = 'http://tp1.sinaimg.cn/1611305952/180/5683416585/2'

    expect(user.refresh).to eq(true)
  end
end
