require 'spec_helper'

describe "Archives Pages" do

	MONTH_RANGE = (0..6)

	subject { page }

	before(:all) do
		MONTH_RANGE.each do |i|
			FactoryGirl.create(:post, release_date: Time.now - i.months, title: "Post Number #{i}" )
		end
		FactoryGirl.create(:post, release_date: Time.now + 1.month, title: "Future Post")
	end

	after(:all) { Post.delete_all }

	describe "index" do
		before do 
			visit archives_url
		end

		it { should have_selector('title', text: full_title('Archives')) }
		it { should have_selector('h1', text: 'Archives') }

		it { should have_xpath(APP_STYLESHEET_XPATH) }

		MONTH_RANGE.each do |i|
			it { should have_selector('li a', text: "Post Number #{i}") }
		end

		it "has properly formatted date headings" do
			find(:css, 'div#archives h2').text.should eq( Time.now.strftime("%B %Y") )
		end

	end

end