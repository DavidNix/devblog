require 'spec_helper'

describe "StaticPages" do

  subject { page }

  describe "Home page" do
    before { visit root_path }
    it { should have_selector('title', text: full_title('')) }
    it { should_not have_selector 'title', text: '| Home' }
    it { should have_xpath("//html/head/link[@href='#{articles_url}.atom']")}
  end

  describe "About page" do
  	before { visit about_path }
  	it { should have_selector('title', text: full_title('About')) }
  	it { should have_selector('title', text: '|') } 
  end

end