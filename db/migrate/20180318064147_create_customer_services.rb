class CreateCustomerServices < ActiveRecord::Migration[5.1]
  def change
    create_table :customer_services do |t|      
      t.string :password_digest, null: false      
      t.string :username
      t.string :mobile
      t.string :email      
      t.timestamps
    end
  end
end
