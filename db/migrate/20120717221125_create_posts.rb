class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title
      t.date :release_date
      t.string :teaser
      t.text :content
      t.string :permalink

      t.timestamps
    end
  end
end
