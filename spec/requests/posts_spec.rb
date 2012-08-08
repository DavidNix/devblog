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

end
