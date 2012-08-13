require 'spec_helper'

describe PostsController do

  before(:each) do
    admin = FactoryGirl.create(:admin)
    sign_in admin
  end

  describe "GET index" do

    it "populates an array of posts" do
    	post = FactoryGirl.create(:post)
    	get :index
    	assigns(:posts).should eq([post])
    end

    it "renders the :index view" do
    	get :index
    	response.should render_template :index
    end

    it "orders the posts in descending order" do
      2.times { FactoryGirl.create(:post) }
      get :index
      assigns(:posts).first.release_date.should > assigns(:posts).last.release_date
    end
  end

  describe "GET show" do
    it "assigns the requested post to @post" do
      post = FactoryGirl.create(:post)
      get :show, id: post
      assigns(:post).should eq(post)
    end

    it "renders the :show template" do
      post = FactoryGirl.create(:post)
      get :show, id: post
      response.should render_template :show
    end
  end

  describe "GET new" do
    it "assigns a new post to @post" do
      get :new
      assigns(:post).should be_a_new(Post)
    end

    it "renders the :new template" do
      get :new
      response.should render_template :new
    end
  end

  describe "GET edit" do
    it "assigns the requested post to @post" do
      post = FactoryGirl.create(:post)
      get :edit, id: post
      assigns(:post).should eq(post)
    end

    it "renders the :edit template" do
      post = FactoryGirl.create(:post)
      get :edit, id: post
      response.should render_template :edit
    end
  end

end
