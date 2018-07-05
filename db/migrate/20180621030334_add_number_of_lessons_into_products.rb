class AddNumberOfLessonsIntoProducts < ActiveRecord::Migration[5.1]
  def change
  	add_column :products, :number_of_lessons, :integer, default: 0, after: :pictures
  end
end
