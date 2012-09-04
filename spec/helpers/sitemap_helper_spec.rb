require 'spec_helper'

describe SitemapHelper do

	describe "W3C time" do
		time_regex = /\d{4}-\d{2}-\d{2}/

		it "has correctly formatted date" do
			w3c_time.should =~ time_regex
			w3c_time(Time.new(2010,1,2)).should eq("2010-01-02")
		end

		it "has the correct article date" do
			early_date = Time.new(2010,2,24)
			later_date = Time.new(2012,3,30)
			article = FactoryGirl.build(:post, updated_at: early_date, release_date: later_date)

			article_date(article).should eq("2012-03-30")

			article.release_date = early_date
			article.updated_at = later_date

			article_date(article).should eq("2012-03-30")
		end
	end
end