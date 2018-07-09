class PaymentsController < ApplicationController
  skip_before_action :verify_authenticity_token
	before_action :set_request_payload, only: [:notify]
	def notify
    if @request_payload['trade_type'] == 'APP'
      opts = { key: 'c991600de2703fd6b3ccfb057cdb2ef5' }
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
end