require 'spec_helper'

describe "AdminRegistrations" do

  subject { page }

  describe "Blog Sign in page" do
    before { visit admin_path }
    
    it { should have_selector('h2',    text: 'Blog Admin Sign In') }
    it { should have_selector('title', text: full_title('Admin Sign In')) }

  end

  describe "sign up process" do

    context "with valid information" do

      let (:admin1) { FactoryGirl.build(:admin) }
      before do 
        visit admin_path
        click_link "Sign up"
        fill_in "Email", with: admin1.email
        fill_in "Password", with: admin1.password
        fill_in "Password confirmation", with: admin1.password_confirmation
        click_button "Sign up"
      end
      it { should have_selector('div.alert', text: 'Welcome! You have signed up successfully.') }
      it { should have_selector('title', text: full_title('All Posts')) }
    end

    context "with a 2nd admin user" do

      before do
        FactoryGirl.create(:admin)
        visit new_admin_registration_path
      end

      it { should have_selector('div.alert', text: 'Unable to create new admin.') }
      it { Admin.all.count.should == 1 }

    end

  end

  describe "sign in process" do

    context "with invalid information" do
      before do 
        visit admin_path
        fill_in "Email", with: "abcdefg"
        fill_in "Password", with: ""
        click_button "Sign in"
      end

      it { should have_selector('div.alert', text: 'Invalid') }
      it { should have_selector('title', text: full_title('Admin Sign In')) }

    end

    context "with valid information" do

      let (:admin2) { FactoryGirl.create(:admin) }

      before do
        visit admin_path
        fill_in "Email", with: admin2.email
        fill_in "Password", with: admin2.password
        click_button "Sign in"
      end
      it { should have_selector('div.alert', text: 'Signed in successfully.')}
      it { should have_selector('a', text: 'Sign Out') }
      it { should have_selector('a', text: 'Posts') }
    end
  end

end