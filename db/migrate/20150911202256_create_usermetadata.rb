class CreateUsermetadata < ActiveRecord::Migration
  def change
    create_table :usermetadata do |t|
      t.integer :user_id
      t.integer :post_id
      t.boolean :like
      t.timestamps null: false
    end
  end
end
