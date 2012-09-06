class AddPublishInfoToPosts < ActiveRecord::Migration
  def change
  	add_column :posts, :publish_ready, :boolean, default: false
  end
end
