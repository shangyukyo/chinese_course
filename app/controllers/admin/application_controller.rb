class Admin::ApplicationController < ApplicationController

	before_action :login_required
	helper_method :current_user

	def login_required
	end

	def current_user
	end

end