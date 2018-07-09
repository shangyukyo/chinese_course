class ProductsController < ApplicationController
	before_action :find_product, only: [:show, :confirm]	
	skip_before_action :login_required, only: [:success]
	def index
	end
	

	def show
	end

	def confirm
	end

	def pay		
    begin
      Payment.transaction {
        opts = {
          student: current_student,
          product_id: params[:product_id],
          state: params[:state],
          city: params[:city],
          region: params[:region],
          street: params[:street]
        }
      	order, payment = Order.checkout opts

        opts = {}

        ip = request.env['HTTP_X_REAL_IP'].presence || request.remote_ip
        ip = '127.0.0.1' if ip.include?(':') or Rails.env.development?
        
        opts.merge!(spbill_create_ip: ip)
    
        ret = { 
          success: true, 
          execute_payload: payment.execute_url(opts),
          client: 'WECHAT', 
          payment_method: 'WECHAT',
          payment_id: payment.id 
        }

        render json: ret
      }
    rescue => e
      raise e      
      render json: { success: false, error: '请求支付出错，请重试或者联系客服' }
    end

	end


	private

	def find_product
		@product = Product.find params[:id]
	end
end