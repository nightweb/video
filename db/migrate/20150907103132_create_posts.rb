class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title
      t.text :description
      t.string :slug
      t.string :video_id
      t.timestamps
    end
  end
end
