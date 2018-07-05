class AddProductIdIntoOrder < ActiveRecord::Migration[5.1]
  def change
  	add_column :orders, :product_id, :integer,  after: :student_id
  end
end
