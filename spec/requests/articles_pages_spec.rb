require 'spec_helper'

describe "Articles Pages" do

	subject { page }

	before(:all) do
		int = devblog_rand(50) + 5
		int.times { FactoryGirl.create(:post) }
	end

	after(:all) { Post.delete_all }

	describe "index" do

		before do
			# visit "articles?page=#{page_num}"
			visit articles_path
		end

		it { should have_selector('title', text: 'Articles') }

		context "pagination" do
			it { should have_selector('div.pagination') }
			it { should have_link 'Read More' }

			it "should list each article" do 
				Post.published_with_pagination(1).each do |article|
					page.should have_selector('h3', text: article.title )
					page.should have_selector('p', text: article.published_date)
					page.should have_selector('p', text: article.teaser)
				end
			end
		end
	end
	
	describe "show" do
		
		let (:article) { Post.published_with_pagination(1).first }
		before do
			visit articles_path
			within(:css, "div#article_#{article.id}") { click_link "Read More" }
		end

		it { should have_selector('title', text: article.title) }
		it { should have_selector('h2', text: article.title) }
		it { should have_content article.published_date }
		it { should have_selector('div', text: article.content) }

	end
end
