class AddReadCountToPosts < ActiveRecord::Migration
  def change
  	# helps determine popularity of posts/articles
  	add_column :posts, :read_count, :integer, default: 0
  end
end
