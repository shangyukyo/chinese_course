class CreateStudentsProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :students_products do |t|
    	t.belongs_to :student
    	t.belongs_to :product
    	t.integer :state
      t.timestamps
    end
  end
end
