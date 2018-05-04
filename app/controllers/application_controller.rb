class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :login?, :current_user, :set_title
  before_action :login_required
  
  def login_required    
    unless login?            
      wechat_auth_step1
    end
  end

  def no_login_required
    if login?
      redirect_to root_url
    end
  end

  def current_user
    @current_user ||= login_from_session || login_from_cookies unless defined?(@current_user)
    @current_user
  end

  def login?
    !!current_user
  end

  def login_as(user)
    session[:user_id] = user.id
    @current_user = user    
  end


  def login_from_session
    if session[:user_id].present?
      begin
        User.find session[:user_id]
      rescue
        session[:user_id] = nil
      end
    end
  end

  def login_from_cookies
    if cookies[:remember_token].present?
      if user = User.find_by_remember_token(cookies[:remember_token])
        session[:user_id] = user.id
        user
      else
        forget_me
        nil
      end
    end
  end

  def wechat_auth_step1
    session[:return_to] = request.original_url
    redirect_uri = ERB::Util.url_encode("http://shandong-car.com/sign_in")  
    redirect_to "https://open.weixin.qq.com/connect/oauth2/authorize?appid=#{Setting.wechat.AppID}&redirect_uri=#{redirect_uri}&response_type=code&scope=snsapi_userinfo&state=STATE#wechat_redirect"
  end

  def set_title
    @title || '汉语桥'
  end
end
