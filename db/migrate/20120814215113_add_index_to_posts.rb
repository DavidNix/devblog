class AddIndexToPosts < ActiveRecord::Migration
  def change
  	add_index :posts, :permalink, :unique => true
  end
end
