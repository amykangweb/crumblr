class DropImageFromPost < ActiveRecord::Migration
  def change
  	remove_column :posts, :image
  end
end
