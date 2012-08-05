class ChangePostDate < ActiveRecord::Migration
	def change
		change_column :posts, :release_date, :datetime
	end
end
