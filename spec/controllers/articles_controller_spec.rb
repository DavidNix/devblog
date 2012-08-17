require 'spec_helper'

describe ArticlesController do

  describe "GET index" do

    it "populates an array of articles" do
      article = FactoryGirl.create(:post, release_date: Time.now)
    	get :index
    	assigns(:articles).should eq([article])
    end

    it "renders the :index view" do
    	get :index
    	response.should render_template :index
    end

    it "orders the articles in descending order" do
      FactoryGirl.create(:post, release_date: Time.now)
      FactoryGirl.create(:post, release_date: Time.local(Time.now.year - rand(5), Time.now.month, Time.now.day) )
      get :index
      assigns(:articles).first.release_date.should >= assigns(:articles).last.release_date
    end
  end

  describe "GET show" do
    it "assigns the requested post to @article" do
      article = FactoryGirl.create(:post)
      get :show, id: article
      assigns(:article).should eq(article)
    end

    it "renders the :show template" do
      article = FactoryGirl.create(:post)
      get :show, id: article
      response.should render_template :show
    end
  end
end
