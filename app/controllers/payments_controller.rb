class PaymentsController < ApplicationController
  skip_before_action :login_required
  skip_before_action :verify_authenticity_token
	before_action :set_request_payload, only: [:notify]

	def notify
    if @request_payload['trade_type'] == 'APP'
      opts = { key: 'cdd6233a858573bf100269ee28ed01ce' }
    else
      opts = {}
    end   

    if !WxPay::Sign.verify?(@request_payload, opts)
      return render_fail('签名失败')
    end

    find_payment
    return render_succeed if @payment.completed?

    if @request_payload['return_code'] == 'SUCCESS'
      @payment.complete!      
      render_succeed
    else
      render_fail
    end		
	end


	private

  def set_request_payload
    @checkout_method = params[:method]
    @request_payload = Hash.from_xml(URI.decode(request.body.read))['xml']
  end

  def render_succeed
    render json: {success: true}
  end

  def render_fail msg = "服务器错误"
    render json: {success: false, msg: msg}
  end

  def find_payment
    payment_no = @request_payload['out_trade_no']
    transaction_id = @request_payload['transaction_id']

    @payment = Payment.find_by!(number: payment_no)

    @payment.payment_transacation_id = transaction_id
    @payment.notified = true    
    @payment.save!
  end  
end