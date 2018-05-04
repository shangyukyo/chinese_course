class Admin::ApplicationController < ActionController::Base
	protect_from_forgery with: :exception
	layout 'admin'
	
	before_action :login_required
	helper_method :current_user

	def login_required
	end

	def current_user
	end

end