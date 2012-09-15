require 'spec_helper'

describe "StaticPages" do

  subject { page }

  describe "Home page" do
    before { visit root_path }
    it { should have_selector('title', text: full_title('')) }
    it { should_not have_selector 'title', text: '| Home' }
    it { should have_xpath("//html/head/link[@href='#{articles_url}.atom']") }
    it { should have_xpath("//html/head/meta[@charset='utf-8']") }
    it { should have_xpath("//html/head/meta[@name='description']") }
    it { should have_xpath("//html/head/meta[@content]") }
  end

  describe "About page" do
  	before { visit about_path }
  	it { should have_selector('title', text: full_title('About')) }
  	it { should have_selector('title', text: '|') } 
  end

end