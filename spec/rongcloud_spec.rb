require 'rongcloud'

describe Rongcloud::Service::User do
  # it 'get user token test' do
  #   Rongcloud.app_key = 'YOUR_SECRET'
  #   Rongcloud.app_secret = 'YOUR_SECRET'
  #
  #   user = Rongcloud::Service::User.new
  #
  #   user.user_id = 2
  #   user.name = '柳溪'
  #   user.portrait_uri = 'http://tp1.sinaimg.cn/1611305952/180/5683416585/1'
  #   user.get_token
  #
  #   expect(user.token).to match /.{10,256}/
  # end
  #
  #
  # it 'update user info test' do
  #   Rongcloud.app_key = 'YOUR_SECRET'
  #   Rongcloud.app_secret = 'YOUR_SECRET'
  #
  #   user = Rongcloud::Service::User.new
  #
  #   user.user_id = 2
  #   user.name = '柳溪XXXX'
  #   user.portrait_uri = 'http://tp1.sinaimg.cn/1611305952/180/5683416585/2'
  #
  #   expect(user.refresh).to eq(true)
  # end

  # it 'pulish private message test' do
  #   Rongcloud.app_key = 'm7ua80gbuufgm'
  #   Rongcloud.app_secret = 'sEzCQ7F8SwREN'
  #
  #   model = Rongcloud::Service::Message.new
  #   model.from_user_id = '10086'
  #   model.to_user_id = '0fd11abae5ce150247bf95831ee2d939'
  #   model.object_name = 'RC:TxtMsg'
  #
  #   txt_msg = Rongcloud::Service::RCTxtMsg.new
  #   txt_msg.content = 'good job'
  #   txt_msg.extra = 'hello extra'
  #
  #   expect(model.private_publish txt_msg).to eq(true)
  # end


  it 'pulish system message test' do
    Rongcloud.app_key = 'm7ua80gbuufgm'
    Rongcloud.app_secret = 'sEzCQ7F8SwREN'

    #多图文消息
    model = Rongcloud::Service::Message.new
    model.from_user_id = '10086'
    model.to_user_id = '0fd11abae5ce150247bf95831ee2d939'
    model.object_name = 'CU:MoreImgTextMsg'
    model.push_content = '测试'
    model.push_data = '测试'

    # model.object_name = 'RC:ImgTxtMsg'

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

    expect(model.system_public txt_msg).to eq(true)
  end

  # it 'get message history test' do
  #   Rongcloud.app_key = 'YOUR_SECRET'
  #   Rongcloud.app_secret = 'YOUR_SECRET'
  #
  #   model = Rongcloud::Service::Message.new
  #   sync_msg = ->(date_str) do
  #     ('00'..'23').to_a.each { |h|
  #       history = model.history("#{date_str}#{h}")
  #       if history[:code]==200 && history[:url] && history[:url].include?('http')
  #         system(" curl -o tmp/#{history[:date]}.zip #{history[:url]}")
  #         system(" unzip -o tmp/#{history[:date]}.zip -d tmp/")
  #       end
  #       expect(history[:code]).to eq(200)
  #     }
  #   end
  #   sync_msg.call(Time.now.strftime('%Y%m%d'))
  #   sync_msg.call(DateTime.parse((Time.now.to_time-24*60*60).to_s).strftime('%Y%m%d'))
  # end


end
