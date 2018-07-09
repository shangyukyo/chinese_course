class Admin::StudentsController < Admin::ApplicationController

	def index
		@students = Student.all.order('id desc')
	end

	def new
		@student = Student.find params[:id]		
	end

	def create
		@student = Student.find params[:student_id]		
		l = @student.lessons.build
		l.teacher_id = params[:teacher_id]
		l.start_at = params[:start_at]
		l.end_at = params[:end_at]
		l.save

		redirect_to admin_lessons_path
	end
end