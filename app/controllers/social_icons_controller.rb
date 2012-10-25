class SocialIconsController < ApplicationController

	# Purpose of this controller is to allow testing different subscribe options using a gem such as Split.

  def rss
  	redirect_to DevblogExtensions::FEED_URL
  end

  def email
  	redirect_to DevblogExtensions::EMAIL_FEED_URL
  end

  def twitter
  	redirect_to DevblogExtensions::TWITTER_URL
  end
end
