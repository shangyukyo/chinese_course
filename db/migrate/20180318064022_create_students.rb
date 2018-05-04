class CreateStudents < ActiveRecord::Migration[5.1]
  def change
    create_table :students do |t|
      t.string :mobile, null: false
      t.string :email
      t.string :wechat     
      t.integer :gender, default: -1, limit: 1
      t.string :wx_openid
      t.string :wx_unionid
      t.integer :number_of_lessons
      t.datetime :expired_at      
      t.datetime :locked_at, default: nil
      t.text :extras
      t.timestamps
    end
  end
end
