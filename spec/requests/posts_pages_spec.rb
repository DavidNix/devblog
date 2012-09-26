require 'spec_helper'

describe "Posts pages" do

	subject { page }

	let(:admin) { FactoryGirl.create(:admin) }

	before(:all) do 
		40.times { FactoryGirl.create(:post) }
		FactoryGirl.create(:post, release_date: Time.now + 1.month, title: "Future Post 1")
		FactoryGirl.create(:post, release_date: Time.now, read_count: 50, title: "Read count article")
	end
	after(:all) { Post.delete_all }

	before(:each) do
		#sign in process
		visit admin_url
        fill_in "Email", with: admin.email
        fill_in "Password", with: admin.password
        click_button "Sign in"
	end

	describe "index" do
		before do 
			visit posts_url
		end

		it { should have_selector('title', text: 'All Posts') }
		it { should have_xpath(ADMIN_STYLESHEET_XPATH) }

		context "pagination" do
			it { should have_selector('div.pagination') }

			it "should list each post" do 
				Post.paginate(page: 1, order: 'release_date desc').each do |post|
					page.should have_selector('h2', text: post.title )
				end
			end
		end

		context "sidebars" do
			it {should have_selector('div.sidebar#future', text: "Upcoming Articles") }
			it {should have_selector('div.sidebar#future ul li p a', text: "Future Post 1")}

			it {should have_selector('div.sidebar#popular', text: "Popular Articles") }
			it {should have_selector('div.sidebar#popular ul li p a', text: "Read count article")}
			it {should have_selector('div.sidebar#popular ul li p', text: "Read count: 50")}

		end
	end

	describe "new" do
		before do
			visit posts_url
			click_link "New Post"
		end
		it { should have_selector('h1', text: "New post") }
		it { should have_xpath(ADMIN_STYLESHEET_XPATH) }
	end

	describe "edit" do
		let (:post) { Post.order('release_date desc').first }
		before do 
			visit posts_url
			within(:css, "div#post_#{post.id}") { click_link "Edit" }
		end

		it { should have_selector('title', text: "Editing #{post.title}" ) }
		it { should have_selector('h1', text: "Editing post") }
		it { should have_xpath(ADMIN_STYLESHEET_XPATH) }
	end

	describe "create" do
		describe "shows valid selectors" do
			before do
				visit posts_url
				click_link "New Post"
				post = FactoryGirl.build(:post)
				fill_in "Title", with: "Test Title 101"
				fill_in "Permalink", with: post.permalink
				fill_in "Teaser", with: post.teaser
				fill_in "Content", with: post.content
				click_button "Save"
			end
			it { should have_selector('div.alert.alert-success', text: "Post was successfully created.") }
			it { should have_content 'Test Title 101' }
		end

		describe "saves the post to the database" do
			before do
				visit posts_url
				click_link "New Post"
				post = FactoryGirl.build(:post)
				fill_in "Title", with: post.title
				fill_in "Permalink", with: post.permalink
				fill_in "Teaser", with: post.teaser
				fill_in "Content", with: post.content
			end
			it { expect { click_button "Save" }.to change(Post, :count).by(1) }
		end

		describe "does not allow posts with duplicate permalinks" do
			before do
				visit posts_url
				click_link "New Post"
				post = FactoryGirl.build(:post)
				fill_in "Title", with: post.title
				fill_in "Permalink", with: "test permalink 1"
				fill_in "Teaser", with: post.teaser
				fill_in "Content", with: post.content
				click_button "Save"

				click_link "Back"
				click_link "New Post"
				post = FactoryGirl.build(:post)
				fill_in "Title", with: post.title
				fill_in "Permalink", with: "test   PERMALINK-1"
				fill_in "Teaser", with: post.teaser
				fill_in "Content", with: post.content
				click_button "Save"
			end

			it { should have_content "has already been taken" }

		end

	end

	describe "delete" do
		before do
			visit posts_url
			click_link "Edit"
		end

		it { expect { click_link "Delete"}.to change(Post, :count).by(-1) }
	end

end
