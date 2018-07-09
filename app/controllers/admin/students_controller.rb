class Admin::StudentsController < Admin::ApplicationController

	def index
		@students = Student.all.order('id desc')
	end

	def new
	end
end