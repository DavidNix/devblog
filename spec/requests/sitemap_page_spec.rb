require 'spec_helper'

describe "Sitemap Page" do

	subject { page }

	before(:each) do
		FactoryGirl.create(:post, updated_at: Time.now, release_date: Time.new(2012,1,1) )
	end

	describe "index" do
		before do
			visit ('/sitemap.xml')
		end

		it { should have_xpath("//urlset[@xmlns='http://www.sitemaps.org/schemas/sitemap/0.9']") }

		it { should have_xpath('//urlset/url/loc') }
		it { should have_xpath('//urlset/url/lastmod') }
		it { should have_xpath('//urlset/url/changefreq') }
		it { should have_xpath('//urlset/url/priority') }

		it { should have_xpath('//urlset/url/loc', text: article_url(Post.published.first)) }

		it { should have_xpath('//urlset/url/loc', text: root_url) }
		it { should have_xpath('//urlset/url/loc', text: about_url) }
		it { should have_xpath('//urlset/url/loc', text: contact_url) }

	end

end