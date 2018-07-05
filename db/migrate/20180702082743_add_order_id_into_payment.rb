class AddOrderIdIntoPayment < ActiveRecord::Migration[5.1]
  def change
  	add_column :payments, :order_id, :string,  after: :student_id
  end
end
