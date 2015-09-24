class AddPostsColumn < ActiveRecord::Migration
  def change
    add_column :posts, :cat_id, :integer
    add_column :posts, :viewed, :integer
    add_column :posts, :liked, :integer
    add_column :posts, :disliked, :integer
  end
end
