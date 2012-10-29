require 'spec_helper'

describe "Articles Pages" do

	subject { page }

	before(:all) do
		int = devblog_rand(50) + 5
		int.times { FactoryGirl.create(:post) }
		# at least one has to be a current date, future date, and past date
		FactoryGirl.create(:post, release_date: Time.now - 1.minute, read_count: 10 )
		FactoryGirl.create(:post, release_date: Time.now + 1.month)
		FactoryGirl.create(:post, release_date: Time.now - 1.month)

		FactoryGirl.create(:post, title: "I'm unpublished.", release_date: Time.now, publish_ready: false)
		FactoryGirl.create(:post, title: "Post Title", release_date: Time.now, teaser: "Teaser with a [link](http://example.com) and **strong** text.")
	end

	after(:all) { Post.delete_all }

	describe "index" do
		context "html" do
			# let (:unpublished_article) { FactoryGirl.create(:post, title: "I'm unpublished.", release_date: Time.now, publish_ready: false) }
			# let (:teaser_markdown) { FactoryGirl.create(:post, title: "Post Title", release_date: Time.now, teaser: "Teaser with a [link](http://example.com) and **strong** text.") }
			before do
				# visit "articles?page=#{page_num}"
				visit articles_url
				# save_and_open_page
			end

			it { should have_selector('title', text: full_title('Articles')) }
			it { should have_selector('div.pagination') }
			it { should have_link 'Read More' }
			it { should have_xpath(APP_STYLESHEET_XPATH) }
			it { should have_xpath(RSS_XPATH) }

			it "does not list the unpublished article" do
				page.should_not have_content("I'm unpublished.")
			end

			it "lists each article" do 
				Post.published_with_pagination(1).each do |article|
					page.should have_selector('h2', text: article.title )
					page.should have_selector('p', text: article.published_date)
				end
			end

			it "has markdown for teaser" do
				page.should have_selector('div.article-snippet div.heading h2', text: "Post Title")
			 	page.should have_selector('div.article-snippet div.body a', text: "link", href: "http://example.com")
			 	page.should have_selector('div.article-snippet div.body p strong', text: "strong")
			end

		end

		context "atom feed" do
			let (:first_post) { Post.published.first }
			let (:last_post) { Post.published.last }
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

			# to account for pagination in the controller
			it { should have_selector(:xpath, '//feed/entry/title', text: last_post.title)}
			it { should have_selector(:xpath, '//feed/entry/content', text: last_post.content)}

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
				visit articles_url
				within(:css, "div#article_#{article.id}") { click_link "Read More" }
				# save_and_open_page
			end

			it { should have_selector('title', text: full_title(article.title, true)) }
			it { should_not have_selector('title', text: DevblogExtensions::WEBSITE_NAME) }
			it { should have_selector('h1', text: article.title) }
			it { should have_content article.published_date }
			it { should have_selector('div', text: article.content) }
			it { should have_xpath(APP_STYLESHEET_XPATH) }
			# we want the search engine to choose the display text, so no meta description should be present
			it { should_not have_xpath("//html/head/meta[@name='description']") }
		end

		context "with markdown in content" do
			let (:article) { FactoryGirl.create(:post, content:
				"# Heading 1 \n## Heading 2 \n### Heading 3 \nExample of **strong text**. \n[Example link](http://example.com)" ) }
			before do 
				visit article_path(article)
				# save_and_open_page
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

			it { should have_content(GOOGLE_ANALYTICS_CONTENT) }
			it "increments the read_count correctly" do
				Post.find(article.id).read_count.should eq(visits)
			end
		end

		context "with sidebars" do
			let (:article) { Post.published.last }
			before do
				visit article_path(article)
			end

			it "should have future sidebar" do
				page.should have_selector('div#future h2', text: "Upcoming")
				page.should have_selector('div#future ul li', text: Post.future_articles.first.title)
			end

			it "should have recent sidebar" do
				page.should have_selector('div#recent h2', text: "Recent")
				page.should have_selector('div#recent ul li a', text: Post.published.first.title)
			end

			it "should have popular sidebar" do
				page.should have_selector('div#popular h2', text: "Popular")
				page.should have_selector('div#popular ul li a', text: Post.popular_articles.first.title)
			end

		end

		context "disqus comments" do
			let (:article) { Post.published.last }
			before do
				visit article_path(article)
			end
			it { should have_xpath("//div[@id='disqus_thread']") }
			it { should have_content("var disqus_shortname = '#{DevblogExtensions::DISQUS_SHORTNAME}'")}
			it { should have_content("var disqus_identifier = #{article.id}") }
			it { should have_content("var disqus_developer = 1") }
			it { should have_content("var disqus_title = '#{article.title}'") }
			it { should have_content("var disqus_url = '#{article_url(article)}'") }


		end
	end

end
