require 'spec_helper'

describe "ErrorPages" do

  subject { page }

  error_404_title = full_title('Page Not Found')
  error_404_text = "The page you were looking for doesn't exist."

  error_500_title = full_title('Error')
  error_500_text = "We're sorry, but something went wrong."

  describe "Error 404" do

    context "incorrect routing" do
      before { visit '/path/does/not/exist' }
      it { should have_selector('title', text: error_404_title) }
      it { should have_selector('h1', text: error_404_text) }
      # response will not be 404 because routing error is on the rack level
    end

    context "future article" do
      let (:future_article) { FactoryGirl.create(:post, permalink: "future", release_date: Time.now + 1.day) }
      before do
        visit article_url(future_article)
      end
      it { should have_selector('title', text: error_404_title) }
      it { should have_selector('h1', text: error_404_text) }

    end

    context "incorrect permalink" do
      before { visit '/articles/unknown-permalink' }
      it { should have_selector('title', text: error_404_title) }
      it { should have_selector('h1', text: error_404_text) }
    end
  end

  describe "Error 500"

end