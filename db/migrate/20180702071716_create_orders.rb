class CreateOrders < ActiveRecord::Migration[5.1]
  def change
    create_table :orders do |t|
      t.belongs_to :student            
      t.decimal :total, precision: 10, scale: 2, default: 0.0
      t.string :order_no, null: false, unique: true, index: true
      t.integer :payment_state, default: 0, index: true
      t.string :state
      t.string :city
      t.string :region
      t.string :street

      t.text :remarks
      t.text :extras

      t.datetime :deleted_at
      t.timestamps

    end
  end
end
