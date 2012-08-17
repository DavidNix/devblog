require 'spec_helper'

describe "Posts pages" do

	subject { page }

	let(:admin) { FactoryGirl.create(:admin) }

	before(:all) { 40.times { FactoryGirl.create(:post) } }
	after(:all) { Post.delete_all }

	before(:each) do
		#sign in process
		visit admin_path
        fill_in "Email", with: admin.email
        fill_in "Password", with: admin.password
        click_button "Sign in"
	end

	describe "index" do
		before do 
			visit posts_path
		end

		it { should have_selector('title', text: 'All Posts') }

		context "pagination" do
			it { should have_selector('div.pagination') }

			it "should list each post" do 
				Post.paginate(page: 1, order: 'release_date desc').each do |post|
					page.should have_selector('h3', text: post.title )
				end
			end
		end
	end

	describe "new" do
		before do
			visit posts_path
			click_link "New Post"
		end
		it { should have_selector('h1', text: "New post") }
	end

	describe "edit" do
		let (:post) { Post.order('release_date desc').first }
		before do 
			visit posts_path
			within(:css, "div#post_#{post.id}") { click_link "Edit" }
		end

		it { should have_selector('title', text: "Editing #{post.title}" ) }
		it { should have_selector('h1', text: "Editing post") }
	end

	describe "create" do
		describe "shows valid selectors" do
			before do
				visit posts_path
				click_link "New Post"
				post = FactoryGirl.build(:post)
				fill_in "Title", with: "Test Title 101"
				fill_in "Permalink", with: post.permalink
				fill_in "Teaser", with: post.teaser
				fill_in "Content", with: post.content
				click_button "Save"
			end
			it { should have_selector('div.alert', text: "Post was successfully created.") }
			it { should have_content 'Test Title 101' }
		end

		describe "saves the post to the database" do
			before do
				visit posts_path
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
				visit posts_path
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

			it { should have_content "Permalink has already been taken" }

		end

	end

	describe "delete" do
		before do
			visit posts_path
			click_link "Edit"
		end

		it { expect { click_link "Delete"}.to change(Post, :count).by(-1) }
	end

end
