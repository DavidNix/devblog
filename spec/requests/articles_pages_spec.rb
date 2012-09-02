require 'spec_helper'

describe "Articles Pages" do

	subject { page }

	before(:all) do
		int = devblog_rand(50) + 5
		int.times { FactoryGirl.create(:post) }
		# at least one has to be a current date
		FactoryGirl.create(:post, release_date: Time.now, read_count: 10 )
	end

	after(:all) { Post.delete_all }

	describe "index" do
		context "html" do
			before do
				# visit "articles?page=#{page_num}"
				visit articles_path
			end

			it { should have_selector('title', text: 'Articles') }
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

		context "atom feed" do
			let (:first_post) { Post.published.first }
			before do
				visit ('/articles.atom')
			end
			it { should have_xpath('//feed/id') }
			it { should have_xpath('//feed/link') }
			it { should have_xpath('//feed/title') }

			it { should have_selector(:xpath, '//feed/entry/link', href: article_url(first_post))}
			it { should have_selector(:xpath, '//feed/entry/title', text: first_post.title)}
			it { should have_selector(:xpath, '//feed/entry/content', text: first_post.content)}
			it { should have_selector(:xpath, '//feed/entry/author/name', text: DevblogExtensions::AUTHOR_NAME)}

			it "has the correct updated time" do
				atom_time = find(:xpath, '//feed/updated').text
				post_time = first_post.release_date.strftime("%Y-%m-%dT%H:%M:%SZ")
				atom_time.should eq(post_time)
			end
		end

	end
	
	describe "show" do
		
		context "with no markdown in content" do
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

		context "with markdown in content" do
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

		context "without a signed in admin" do
			let (:article) { FactoryGirl.create(:post, release_date: Time.now) }
			visits = devblog_rand(10)
			before do
				visits.times { visit article_path(article) }
			end

			it "increments the read_count correctly" do
				Post.find(article.id).read_count.should eq(visits)
			end
		end

		context "with sidebars" do
			let (:article) { Post.published.last }
			before do
				visit article_path(article)
			end

			it "should have recent sidebar" do
				page.should have_selector('h2', text: "Recent Articles")
				page.should have_selector('ul li a', text: Post.published.first.title)
			end

			it "should have popular sidebar" do
				page.should have_selector('h2', text: "Popular Articles")
				page.should have_selector('ul li a', text: Post.popular_articles.first.title)
			end

		end
	end

end
