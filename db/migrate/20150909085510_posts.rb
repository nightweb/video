class Posts < ActiveRecord::Migration
  def change
    rename_column :posts, :slug, :status
  end
end
