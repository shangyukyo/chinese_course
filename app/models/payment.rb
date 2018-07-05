class Payment < ApplicationRecord
	belongs_to :order
	belongs_to :student


  def complete!
    self.order.pay!
  end

  before_validation do
    return if self.number.present?

    loop do
      self.number = [       
        '%08d' % SecureRandom.random_number(10000000)
      ].join

      break unless Payment.find_by(number: self.number).present?
    end
  end  

  def execute_url(opts = {})
    checkout_opts = {} 
    checkout_opts = { trade_type: 'JSAPI', openid: student.wx_openid }
    # if payment_method == 'WECHAT'
    #   if client == 'WECHAT'
    #     checkout_opts = { trade_type: 'JSAPI', openid: student.wx_openid }
    #   elsif client == 'PC_WEB'
    #     checkout_opts = { trade_type: 'NATIVE' }
    #   elsif client == 'MOBILE_WEB'
    #     checkout_opts = { 
    #       trade_type: 'MWEB', 
    #       redirect_url: url_helpers.payment_url(self.number, host: 'http://www.chinesecio.org.cn') 
    #     }
    #   else
    #     checkout_opts = { trade_type: 'APP' }
    #   # elsif client == 'MOBILE_WEB'
    #   #   checkout_opts = { 
    #   #     trade_type: 'MWEB', 
    #   #     redirect_url: url_helpers.payment_url(self.payment_no, host: Setting.app_host) 
    #   #   }
    #   # else
    #   #   checkout_opts = { trade_type: 'APP' }
    #   end
    # elsif payment_method == 'ALIPAY'
    #   if !app?
    #     checkout_opts = { 
    #       return_url: url_helpers.payment_url(self.payment_no, host: Setting.app_host) 
    #     }
    #   end
    # end

    opts = checkout_opts.merge(opts)    
    wechat_jsapi_payload(opts)    
  end	

  def wechat_jsapi_payload(opts = {})    
    unifieorder_payload = wechat_unifiedorder_params(opts)
    rsp = WxPay::Service.invoke_unifiedorder(unifieorder_payload)

    payload = {
      "appId"     => Setting.wechat.AppID,
      "nonceStr"  => SecureRandom.hex(16),
      "timeStamp" => Time.now.to_i.to_s,
      "signType"  => 'MD5',
      "package"   => "prepay_id=#{rsp['prepay_id']}"
    }

    payload['paySign'] = WxPay::Sign.generate(payload)
    payload
  end

  def wechat_unifiedorder_params(opts = {})
    # body = subject.gsub(/[^\p{L}\s]+/, '').squeeze(' ').strip rescue "支付订单 - #{payment_no}"
    # body = body.truncate(80)
    payload = {
      body: "支付订单 - #{number}",
      out_trade_no: number,
      total_fee: (self.amount.round(2) * 100).to_i,
      spbill_create_ip: opts[:spbill_create_ip].presence || '127.0.0.1',
      notify_url: notify_url,
      trade_type: opts[:trade_type]
    }

    if opts[:trade_type] == 'JSAPI'
      payload = payload.merge(openid: opts[:openid])
    end

    payload
  end 

  def notify_url
    host = "http://www.chinesecio.org.cn"
    File.join(host, '/payments/notify').to_s
  end


end
