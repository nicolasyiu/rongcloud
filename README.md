# Rongcloud

融云及时通讯server端api

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'rongcloud'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install rongcloud

## 配置基本信息

```ruby
Rongcloud.app_key = 'YOUR_APPKEY' #融云APPKEY
Rongcloud.app_secret = 'YOUR_SECRET' #融云APP_SECRET
```

#### 获取用户TOKEN `/user/getToken`
```ruby
    user = Rongcloud::Service::User.new

    user.user_id = 2
    user.name = 'RONGYUN_USERNAME'
    user.portrait_uri = 'http://tp1.sinaimg.cn/1611305952/180/5683416585/1'
    user.get_token
    user.token
# => adfasdfwere=23/wrewelwerwe==werw
```

#### 刷新用户基本信息 `/user/refresh`
```ruby
    user = Rongcloud::Service::User.new

    user.user_id = 2
    user.name = 'RONGYUN_USERNAME'
    user.portrait_uri = 'http://tp1.sinaimg.cn/1611305952/180/5683416585/1'
    user.refresh
# => true
```

#### 发送单聊消息 `/message/private/publish`
```ruby
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

#### 发送系统消息 `/message/system/publish`
```ruby
    #多图文消息
    model = Rongcloud::Service::Message.new
    model.from_user_id = '10086'
    model.to_user_id = '0fd11abae5ce150247bf95831ee2d939'
    model.object_name = 'CU:MoreImgTextMsg'

    txt_msg = Rongcloud::Service::RCImgTextMsg.new
    txt_msg.title = '订单已签收,请留意!!!!'
    txt_msg.image_uri = 'http://mmbiz.qpic.cn/mmbiz_jpg/sKpnItfibB47q01zqjHEu2B3Ffw9FIzDHk4r8d4p1PbSictuChRDDIPxBialQvmr2s9HAzkZWkYWRREYNZSgQOSKQ/640?wx_fmt=jpeg&tp=webp&wxfrom=5&wx_lazy=1'
    txt_msg.url = 'http://mp.weixin.qq.com/s?__biz=MjM5MDU4Njg5Mw==&mid=2247484325&idx=1&sn=883a0e1e61550b994146fa35161e0d40&scene=0#rd'
    txt_msg.extra = {data: [{
                                title: '【惊喜】送钱又送礼,没想到你是酱紫的?',
                                imageUri: 'http://mmbiz.qpic.cn/mmbiz_png/fJQfMRLCskZ1I8p2jic2twlAKQOsRicMtIxu8YqgmBzqXkNwy4577zEyqDFnNibqaIhEJPJUeXBchLbFGywp4vMxw/640?wx_fmt=png&tp=webp&wxfrom=5&wx_lazy=1',
                                url: 'http://mp.weixin.qq.com/s?__biz=MjM5MDU4Njg5Mw==&mid=2247484325&idx=3&sn=90e918570245390b065f3b6506d54a5c&scene=0#rd'
                            },
                            {

                                title: '【特惠】开学季精明家长备货清单，9.9元起包邮',
                                imageUri: 'http://mmbiz.qpic.cn/mmbiz_png/EEtCXiaicRt14LYqXlCLEK1xTvKFISNB1T948RhDctJuPHKjY03qXh4xKrFNaE9xZRUeMBaKlZnEPwkicLwoKfZMQ/640?wx_fmt=png&tp=webp&wxfrom=5&wx_lazy=1',
                                url: 'http://mp.weixin.qq.com/s?__biz=MjM5MDU4Njg5Mw==&mid=2247484325&idx=4&sn=f73ab4afa29a9842324ae6f5d6e32e83&scene=0#rd'
                            }, {
                                title: '【拔草】快放开我，我控几不住我记几了！',
                                imageUri: 'http://mmbiz.qpic.cn/mmbiz_jpg/EEtCXiaicRt14LYqXlCLEK1xTvKFISNB1ToPw74J7Ra7qh9QsCnaBAp6I9U3Mso9eIYOPvBdtbUnmczhdhDm9snw/640?wx_fmt=jpeg&tp=webp&wxfrom=5&wx_lazy=1',
                                url: 'http://mp.weixin.qq.com/s?__biz=MjM5MDU4Njg5Mw==&mid=2247484325&idx=5&sn=312bbaedacd17220bc5ca73c49890070&scene=0#rd'
                            }]}.to_json
    model.system_publish txt_msg
# => true
```

#### 获取聊天历史记录 `/message/history`
```ruby
    model = Rongcloud::Service::Message.new
    sync_msg = ->(date_str) do
      ('00'..'23').to_a.each { |h|
        history = model.history("#{date_str}#{h}")
        if history[:code]==200 && history[:url] && history[:url].include?('http')
          system(" curl -o tmp/#{history[:date]}.zip #{history[:url]}")
          system(" unzip -o tmp/#{history[:date]}.zip -d tmp/")
        end
        history[:code] # => true
      }
    end
    sync_msg.call(Time.now.strftime('%Y%m%d'))
    sync_msg.call(DateTime.parse((Time.now.to_time-24*60*60).to_s).strftime('%Y%m%d'))
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
