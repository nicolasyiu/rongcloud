# Rongcloud

Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/rongcloud`. To experiment with that code, run `bin/console` for an interactive prompt.

TODO: Delete this and the text above, and describe your gem

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'rongcloud'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install rongcloud

## Configuration

```ruby
Rongcloud.app_key = 'YOUR_APPKEY' #融云APPKEY
Rongcloud.app_secret = 'YOUR_SECRET' #融云APP_SECRET
```

#### 获取用户TOKEN
```ruby
	Rongcloud.app_key = 'YOUR_APPKEY'
    Rongcloud.app_secret = 'YOUR_SECRET'

    user = Rongcloud::Service::User.new

    user.user_id = 2
    user.name = 'RONGYUN_USERNAME'
    user.portrait_uri = 'http://tp1.sinaimg.cn/1611305952/180/5683416585/1'
    user.get_token
    user.token
# => adfasdfwere=23/wrewelwerwe==werw
```

#### 刷新用户基本信息
```ruby
	Rongcloud.app_key = 'YOUR_APPKEY'
    Rongcloud.app_secret = 'YOUR_SECRET'

    user = Rongcloud::Service::User.new

    user.user_id = 2
    user.name = 'RONGYUN_USERNAME'
    user.portrait_uri = 'http://tp1.sinaimg.cn/1611305952/180/5683416585/1'
    user.refresh
# => true
```

#### 发送单聊消息
```ruby
	Rongcloud.app_key = 'YOUR_APPKEY'
    Rongcloud.app_secret = 'YOUR_SECRET'

    model = Rongcloud::Service::Message.new

    model.from_user_id = 2
    model.to_user_id = 1
    model.object_name = 'RC:TxtMsg'
    txt_msg = Rongcloud::Service::RCTxtMsg.new
    txt_msg.content = 'good job'
    txt_msg.extra = 'hello extra'
    model.private_publish txt_msg
# => true
```

#### 获取聊天历史记录
```ruby
	Rongcloud.app_key = 'YOUR_APPKEY'
    Rongcloud.app_secret = 'YOUR_SECRET'

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
# => true
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release` to create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

1. Fork it ( https://github.com/[my-github-username]/rongcloud/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
