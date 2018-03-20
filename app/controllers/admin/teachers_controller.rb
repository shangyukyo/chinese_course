class Admin::TeachersController < Admin::ApplicationController
	before_action :find_teacher, only: [:edit, :update]
	def index
		@teachers = Teacher.all.order('id desc')
	end

	def new
		@teacher = Teacher.new
	end

	def edit		
	end

	def update
		@teacher.update_attributes teacher_params
		redirect_to admin_teachers_path
	end

	def create
		@teacher = Teacher.create!(teacher_params)
		redirect_to admin_teachers_path
	end

	private

	def find_teacher
		@teacher = Teacher.find params[:id]
	end

	def teacher_params
		params.require(:teacher).permit(:username, :mobile, :email, :wechat, :lesson_size)
	end
end