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

  it 'group create test' do
    group = Rongcloud::Service::Group.new
    group.user_id = 2
    group.group_id = 1
    group.group_name = "test"
    expect(group.create).to eq(true)
  end

  it 'group join test' do
    group = Rongcloud::Service::Group.new
    group.user_id = 2
    group.group_id = 1
    group.group_name = "test"
    expect(group.join).to eq(true)
  end

  it 'group query test' do
    group = Rongcloud::Service::Group.new
    group.group_id = 1
    expect(group.query).to eq(true)
  end

  it 'group sync test' do
    model = Rongcloud::Service::Group.new
    model.user_id = 2
    model.groups = {"1" => "test"}
    expect(model.sync).to eq(true)
  end

  it 'group refresh test' do
    group = Rongcloud::Service::Group.new
    group.group_id = 1
    group.group_name = "test"
    expect(group.refresh).to eq(true)
  end

  it 'group quit test' do
    group = Rongcloud::Service::Group.new
    group.user_id = 2
    group.group_id = 1
    expect(group.quit).to eq(true)
  end

  it 'group dismiss test' do
    group = Rongcloud::Service::Group.new
    group.user_id = 2
    group.group_id = 1
    expect(group.dismiss).to eq(true)
  end

end
