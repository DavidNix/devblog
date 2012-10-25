require 'spec_helper'

describe SocialIconsController do

  describe "GET 'rss'" do
    it "retirects" do
      get 'rss'
      response.should redirect_to DevblogExtensions::FEED_URL
    end
  end

  describe "GET 'twitter'" do
    it "redirects" do
      get 'twitter'
      response.should redirect_to DevblogExtensions::TWITTER_URL
    end
  end

  describe "GET 'email'" do
    it "redirects" do
      get 'email'
      response.should redirect_to DevblogExtensions::EMAIL_FEED_URL
    end
  end

end
