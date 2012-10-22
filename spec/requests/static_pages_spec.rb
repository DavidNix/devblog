require 'spec_helper'

describe "StaticPages" do

  subject { page }

  describe "Home page" do
    before { visit root_path }
    it { should have_selector('title', text: full_title('')) }
    it { should_not have_selector 'title', text: '| Home' }
    it { should have_xpath(RSS_XPATH) }
    it { should have_xpath("//html/head/meta[@charset='utf-8']") }
    it { should have_xpath("//html/head/meta[@name='description']") }
    it { should have_xpath("//html/head/meta[@content]") }
    it { should have_xpath(APP_STYLESHEET_XPATH) }
  end

  describe "About page" do
  	before { visit about_path }
  	it { should have_selector('title', text: full_title('About')) }
  	it { should have_selector('title', text: '|') } 
    it { should have_xpath(APP_STYLESHEET_XPATH) }
    it { should have_xpath(RSS_XPATH) }
  end

  describe "Products" do
    before { visit products_path }
    it { should have_selector('title', text: full_title('Products')) }
    it { should have_selector('title', text: '|') } 
    it { should have_xpath(APP_STYLESHEET_XPATH) }
    it { should have_xpath(RSS_XPATH) }
  end

end