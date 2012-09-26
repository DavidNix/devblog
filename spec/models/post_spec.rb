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

	it "ready_to_publish only shows publishable posts" do
		FactoryGirl.create(:post, release_date: Time.now)
		FactoryGirl.create(:post, release_date: Time.now + 1.month)
		Post.ready_to_publish.count.should eq(1)
	end

	it "published shows publishable posts in correct order" do
		now = Time.now
		FactoryGirl.create(:post, release_date: now)
		FactoryGirl.create(:post, release_date: now - 1.month)
		FactoryGirl.create(:post, release_date: now + 1.month)

		publishables = Post.published
		publishables.count.should eq(2)
		publishables.first.release_date.should > publishables.last.release_date
		publishables.first.release_date.should eq(now)
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

	it "popular_articles lists 5 most popular posts in correct order" do
		now = Time.now
		FactoryGirl.create(:post, release_date: now - 1.day, read_count: 10)
		FactoryGirl.create(:post, release_date: now, read_count: 5)
		FactoryGirl.create(:post, release_date: now - 1.month, read_count: 1)

		populars = Post.popular_articles
		populars.count.should eq(3)
		populars.first.read_count.should > populars[1].read_count
		populars[1].read_count.should > populars.last.read_count
		populars.first.read_count.should eq(10)
		populars[1].read_count.should eq(5) # 2nd read_count should be 5
		populars.last.read_count.should eq(1)
	end

	it "future_articles lists the 3 upcoming posts in correct order" do
		present = Time.now
		future1 = Time.now + 1.day
		future2 = Time.now + 1.month
		future3 = Time.now + 1.year
		[present, future1, future2, future3].each do |time|
			FactoryGirl.create(:post, release_date: time)
		end
		FactoryGirl.create(:post, release_date: Time.now + 2.days, publish_ready: false)

		futures = Post.future_articles
		futures.count.should eq(3)
		futures[0].release_date.should eq(future1)
		futures[1].release_date.should eq(future2)
		futures[2].release_date.should eq(future3)

	end

end

# describe Post do
#   pending "add some examples to (or delete) #{__FILE__}"
# end
# == Schema Information
#
# Table name: posts
#
#  id            :integer         not null, primary key
#  title         :string(255)
#  release_date  :datetime
#  teaser        :text(255)
#  content       :text
#  permalink     :string(255)
#  created_at    :datetime        not null
#  updated_at    :datetime        not null
#  read_count    :integer         default(0)
#  publish_ready :boolean         default(FALSE)
#

