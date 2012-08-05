class ChangeTeaserToText < ActiveRecord::Migration
  def change
  	change_column :posts, :teaser, :text
  end
end
