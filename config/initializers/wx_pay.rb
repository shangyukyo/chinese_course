WxPay.appid = Setting.wechat.AppID
WxPay.key = Setting.wechat.AppKey
WxPay.mch_id = Setting.wechat.MchID
WxPay.debug_mode = true # default is `true`
WxPay.sandbox_mode = false # default is `false`

# cert, see https://pay.weixin.qq.com/wiki/doc/api/app/app.php?chapter=4_3
# using PCKS12

WECHAT_PKCS_FILE = Rails.root.join('config/apiclient_cert.p12').to_s

WxPay.set_apiclient_by_pkcs12(File.read(WECHAT_PKCS_FILE), Setting.wechat.MchID)

# if you want to use `generate_authorize_req` and `authenticate`
WxPay.appsecret = Setting.wechat.AppSecret

# optional - configurations for RestClient timeout, etc.
WxPay.extra_rest_client_options = {timeout: 2, open_timeout: 3}