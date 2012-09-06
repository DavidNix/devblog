require 'spec_helper'

describe ArchivesController do

  describe "GET index" do

	  it "populates an array of posts" do
	    article = FactoryGirl.create(:post, release_date: Time.now)
	  	get :index
	  	assigns(:posts).should eq([article])
	  end

	  it "populates an array of post months" do
	  	article = FactoryGirl.create(:post, release_date: Time.now)
	  	article2 = FactoryGirl.create(:post, release_date: Time.now - 1.month)
	  	get :index
	  	assigns(:post_months).count.should eq(2)
	  	post_months = assigns(:posts).group_by { |t| t.release_date.beginning_of_month }
	  	assigns(:post_months).should eq(post_months)

	  end
	end

end