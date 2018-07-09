class Admin::LessonsController < Admin::ApplicationController

	def index
		@lessons = Lesson.all.order('id desc')
	end

	def new
	end
end