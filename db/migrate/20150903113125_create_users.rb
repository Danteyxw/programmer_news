class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username, null: false, unique: true
      t.string :password, null: false
      t.string :about
      t.timestamp null: false
    end
  end
end
