class Admin::IndexController < Admin::ApplicationController

	def login
		if request.post?			
			if params[:username] == 'admin' and params[:password] == '123456'
				session[:logined] = 'yes'		
				redirect_to admin_teachers_path and return		
			end
		end
		render layout: false
	end
end