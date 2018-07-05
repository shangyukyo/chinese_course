class Order < ApplicationRecord
	belongs_to :student
	has_many :payments
	belongs_to :product

  enum payment_state: {
    pending:      0,
    paid:         10,
    failed:      -10
  }

  before_validation do
		return if self.order_no.present?

		loop do
			self.order_no = [				
				'%08d' % SecureRandom.random_number(10000000)
			].join

			break unless Order.find_by(order_no: self.order_no).present?
		end
  end

  def pay!
  	student.number_of_lessons = student.number_of_lessons.to_i + product.number_of_lessons
  	student.save!
  end


  def self.checkout opts
		Order.transaction do 
			product = Product.find opts[:product_id]
			order = opts[:student].orders.build			
			order.total = product.price
			order.product_id = product.id
			order.state = opts[:state]
			order.city = opts[:city]
			order.region = opts[:region]
			order.street = opts[:street]
			order.save
#<Payment id: nil, student_id: nil, order_id: nil, number: nil,
# amount: 0.0, payment_method: nil, state: 0, payment_transacation_id:
# nil, response_code: nil, avs_response: nil, notified: false,
# deleted_at: nil, created_at: nil, updated_at: nil>			
			payment = order.payments.build  	
			payment.student_id = order.student_id
			payment.amount = order.total
			payment.save

			[order, payment]
		end
  end
end
