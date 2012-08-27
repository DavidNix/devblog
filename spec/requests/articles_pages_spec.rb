require 'spec_helper'

describe "Articles Pages" do

	subject { page }

	before(:all) do
		int = devblog_rand(50) + 5
		int.times { FactoryGirl.create(:post) }
		# at least one has to be a current date
		FactoryGirl.create(:post, release_date: Time.now)
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
		it { should have_selector('h1', text: article.title) }
		it { should have_content article.published_date }
		it { should have_selector('div', text: article.content) }

	end

	describe "show with markdown in content" do
			let (:article) { FactoryGirl.create(:post, content:
				"# Heading 1 \n## Heading 2 \n### Heading 3 \nExample of **strong text**. \n[Example link](http://example.com)" ) }
			before do 
				visit article_path(article)
			end

			it { should have_selector('h1', text: "Heading 1") }
			it { should have_selector('h2', text: "Heading 2") }
			it { should have_selector('h3', text: "Heading 3") }
			it { should have_selector('strong', text: "strong text") }
			it { should have_selector('a', text: "Example link", href: "http://example.com") }

	end

	describe "sidebars" do
		let (:article) { Post.published.last }
		before do
			visit article_path(article)
		end

		it "should have recent sidebar" do
			page.should have_selector('h2', text: "Recent Articles")
			page.should have_selector('ul li a', text: Post.published.first.title)
		end

	end
end
