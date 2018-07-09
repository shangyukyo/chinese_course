class Admin::PaymentsController < Admin::ApplicationController

	def index
		@orders = Order.all.order('id desc')
	end

	def new
	end
end