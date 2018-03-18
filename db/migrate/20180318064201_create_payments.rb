class CreatePayments < ActiveRecord::Migration[5.1]
  def change
    create_table :payments do |t|
      t.belongs_to :student,                        index: true
      t.string     :number,               null: false,    unique: true,     index: true
      t.decimal    :amount,                       precision: 12,            scale: 2,     default: 0.0, null: false      
      t.string     :payment_method,               null: false
      t.integer    :state,                        default: 0
      t.string     :payment_transacation_id
      t.string     :response_code
      t.text       :avs_response
      t.boolean    :notified, default: false
      t.datetime   :deleted_at
      t.timestamps    	      
    end
  end
end
