class CreateTeachers < ActiveRecord::Migration[5.1]
  def change
    create_table :teachers do |t|
    	t.string :username
    	t.string :mobile
    	t.string :email    	
      t.timestamps
    end
  end
end
