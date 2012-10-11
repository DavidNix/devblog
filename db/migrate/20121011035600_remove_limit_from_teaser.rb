class RemoveLimitFromTeaser < ActiveRecord::Migration
	def change
		change_column :posts, :teaser, :text, limit: nil
	end
end
