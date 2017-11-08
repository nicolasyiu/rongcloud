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

  it 'group user gag add test' do
    group_user_gag = Rongcloud::Service::GroupUserGag.new
    group_user_gag.user_id = 2
    group_user_gag.group_id = 1
    group_user_gag.minute = "60"
    expect(group_user_gag.add).to eq(true)
  end

  it 'get group user gag list test' do
    group_user_gag = Rongcloud::Service::GroupUserGag.new
    group_user_gag.group_id = 1
    expect(group_user_gag.list).to eq(true)
  end

  it 'group user gag rollback test' do
    group_user_gag = Rongcloud::Service::GroupUserGag.new
    group_user_gag.user_id = 2
    group_user_gag.group_id = 1
    expect(group_user_gag.rollback).to eq(true)
  end

end
