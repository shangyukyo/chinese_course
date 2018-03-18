class CreateLessons < ActiveRecord::Migration[5.1]
  def change
    create_table :lessons do |t|
    	t.belongs_to :student
    	t.belongs_to :teacher
    	t.datetime :start_at
    	t.datetime :end_at
      t.timestamps
    end
  end
end
