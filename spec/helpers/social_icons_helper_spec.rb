require 'spec_helper'

describe SocialIconsHelper do

  it "produces a valid 32 pixel icon" do
    helper.sm_icon(name: "twitter", tool_title: "Test title", href: sm_twitter_path).should eq("<a class=\"sm_32_icon sm_32_twitter sm_shadow\" data-placement=\"bottom\" href=\"/social_icons/twitter\" rel=\"tooltip\" target=\"_blank\" title=\"Test title\"><span></span></a>")
  end

  it "produces a valid 32 pixel icon without a tooltip" do
    helper.sm_icon(name: "twitter", href: sm_twitter_path).should eq("<a class=\"sm_32_icon sm_32_twitter sm_shadow\" data-placement=\"bottom\" href=\"/social_icons/twitter\" rel=\"\" target=\"_blank\"><span></span></a>")
  end

  it "produces a valid 64 pixel icon without a shadow" do
    helper.sm_icon(name: "rss", tool_title: "Test title", href: sm_rss_path, shadow: false, size: 64).should eq("<a class=\"sm_64_icon sm_64_rss \" data-placement=\"bottom\" href=\"/social_icons/rss\" rel=\"tooltip\" target=\"_blank\" title=\"Test title\"><span></span></a>")
  end

  it "produces a 64 pixel icon that won't open in a new window" do
  	helper.sm_icon(name: "rss", tool_title: "Test title", href: sm_rss_path, shadow: false, size: 64, new_window: false).should eq("<a class=\"sm_64_icon sm_64_rss \" data-placement=\"bottom\" href=\"/social_icons/rss\" rel=\"tooltip\" target=\"\" title=\"Test title\"><span></span></a>")
  end

end