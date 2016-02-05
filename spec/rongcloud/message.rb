require 'spec_helper'

describe Rongcloud::Service::Message do
  before(:all) do
    CONFIG = YAML.load(File.open(Rongcloud.root+ '/config.yml')).symbolize_keys
    @config = CONFIG[:rongcloud].symbolize_keys
    Rongcloud.configure do |config|
      config.app_key = @config[:app_key]
      config.app_secret = @config[:app_secret]
      config.api_host = @config[:api_host]
    end
  end

  it 'pulish private message test' do
    model = Rongcloud::Service::Message.new
    model.from_user_id = 2
    model.to_user_id = 1
    model.object_name = 'RC:TxtMsg'
    txt_msg = Rongcloud::Service::RCTxtMsg.new
    txt_msg.content = 'good job'
    txt_msg.extra = 'hello extra'

    expect(model.private_publish txt_msg).to eq(true)
  end

  it 'get message history test' do
    model = Rongcloud::Service::Message.new
    sync_msg = ->(date_str) do
      ('00'..'23').to_a.each { |h|
        history = model.history("#{date_str}#{h}")
        if history[:code]==200 && history[:url] && history[:url].include?('http')
          system(" curl -o tmp/#{history[:date]}.zip #{history[:url]}")
          system(" unzip -o tmp/#{history[:date]}.zip -d tmp/")
        end
        expect(history[:code]).to eq(200)
      }
    end
    sync_msg.call(Time.now.strftime('%Y%m%d'))
    sync_msg.call(DateTime.parse((Time.now.to_time-24*60*60).to_s).strftime('%Y%m%d'))
  end
end
