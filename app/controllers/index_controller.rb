class IndexController < ApplicationController
	skip_before_action :login_required, only: [:sign_in]

	def sign_in				
		o_rsp = RestClient.get "https://api.weixin.qq.com/sns/oauth2/access_token?appid=#{Setting.wechat.AppID}&secret=#{Setting.wechat.AppSecret}&code=#{params[:code]}&grant_type=authorization_code"
		o_r = JSON.parse o_rsp
		info_rsp = RestClient.get "https://api.weixin.qq.com/sns/userinfo?access_token=#{o_r['access_token']}&openid=#{o_r['openid']}&lang=zh_CN "
		info_r = JSON.parse info_rsp

		puts info_r.inspect
		puts "********"
		student = Student.find_by(wx_openid: info_r['openid'])
		if student.present?
			login_as(student)
		else
			student = Student.new			
			student.wx_openid = info_r['openid']
			student.nickname = info_r['nickname']
			student.sex = info_r['sex']
			student.head_img = info_r['headimgurl']
			student.save!
			login_as(student)
		end		
		redirect_to session[:return_to]		
	end
end