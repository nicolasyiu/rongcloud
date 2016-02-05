require 'spec_helper'

describe Rongcloud::Service::Group do
  before(:all) do
    CONFIG = YAML.load(File.open(Rongcloud.root+ '/config.yml')).symbolize_keys
    @config = CONFIG[:rongcloud].symbolize_keys
    Rongcloud.configure do |config|
      config.app_key = @config[:app_key]
      config.app_secret = @config[:app_secret]
      config.api_host = @config[:api_host]
    end
  end

  it 'group sync test' do
    model = Rongcloud::Service::Group.new
    model.user_id = 2
    model.groups = {"1" => "test_group"}
    expect(model.sync).to eq(true)
  end

end
