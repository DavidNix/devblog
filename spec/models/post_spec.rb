require 'spec_helper'

describe Post do
	it "has a valid factory" do
		FactoryGirl.create(:post).should be_valid
	end

	it "is invalid without a title" do
		FactoryGirl.build(:post, title: nil).should_not be_valid
	end
 
	it "is invalid without a teaser" do
		FactoryGirl.build(:post, teaser: nil).should_not be_valid
	end

	it "is invalid without content" do
		FactoryGirl.build(:post, content: nil).should_not be_valid
	end

	it "is invalid without a release date" do
		FactoryGirl.build(:post, release_date: nil).should_not be_valid
	end

	it "is invalid with duplicate permalinks" do
		fake_permalink = "this-is-a-permalink"
		FactoryGirl.create(:post, permalink: fake_permalink)
		FactoryGirl.build(:post, permalink: fake_permalink).should_not be_valid
	end

	it "is invalid with duplicate permalinks that are strangley formatted" do
		fake_permalink_good = "this-is-a-permalink"
		fake_permalink_bad = " this   IS a PermaLINK      "
		FactoryGirl.create(:post, permalink: fake_permalink_good)
		FactoryGirl.build(:post, permalink: fake_permalink_bad).should_not be_valid
	end

	it "is valid with spaces in the permalink" do
		FactoryGirl.build(:post, permalink: " this    is a permalink  ").should be_valid
	end

	it "recent_articles lists the 5 most recent posts" do

		now = Time.now
		FactoryGirl.create(:post, release_date: now)
		5.times do |i|
			FactoryGirl.create(:post, release_date: Time.local(2011,i+1,1, 0,0,0) )
		end
		recents = Post.recent_articles

		recents.count.should eq(5)
		recents.first.release_date.should >= recents.last.release_date
		recents.first.release_date.should eq(now)

	end

	it "popular_articles lists 5 most popular posts" do
		now = Time.now
		FactoryGirl.create(:post, release_date: now, read_count: 10)
		5.times do |i|
			FactoryGirl.create(:post, release_date: Time.local(2011,i+1,1, 0,0,0), read_count: i+1 )
		end
		populars = Post.popular_articles
		populars.count.should eq(5)
		populars.first.read_count.should >= populars.last.read_count
		populars.first.read_count.should eq(10)
		populars[1].read_count.should eq(5) # 2nd read_count should be 5
	end
end

# describe Post do
#   pending "add some examples to (or delete) #{__FILE__}"
# end
# == Schema Information
#
# Table name: posts
#
#  id           :integer         not null, primary key
#  title        :string(255)
#  release_date :datetime
#  teaser       :text(255)
#  content      :text
#  permalink    :string(255)
#  created_at   :datetime        not null
#  updated_at   :datetime        not null
#  read_count   :integer         default(0)
#

