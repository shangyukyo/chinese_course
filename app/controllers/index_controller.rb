class IndexController < ApplicationController
	skip_before_action :login_required, only: [:sign_in]

	def sign_in				
		o_rsp = RestClient.get "https://api.weixin.qq.com/sns/oauth2/access_token?appid=#{Setting.wechat.AppID}&secret=#{Setting.wechat.AppSecret}&code=#{params[:code]}&grant_type=authorization_code"
		o_r = JSON.parse o_rsp
		info_rsp = RestClient.get "https://api.weixin.qq.com/sns/userinfo?access_token=#{o_r['access_token']}&openid=#{o_r['openid']}&lang=zh_CN "
		info_r = JSON.parse info_rsp

		puts info_r.inspect
		puts "********"
		user = User.find_by(wx_openid: info_r['openid'])
		if user.present?
			login_as(user)
		else
			user = User.new			
			user.wx_openid = info_r['openid']
			user.nickname = info_r['nickname']
			user.sex = info_r['sex']
			user.city = info_r['city']
			user.province = info_r['province']
			user.head_img = info_r['headimgurl']
			user.save!
			login_as(user)
		end		
		redirect_to session[:return_to]		
	end
end