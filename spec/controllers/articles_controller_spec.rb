require 'spec_helper'

describe ArticlesController do

  describe "GET index" do

    context "html" do
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

      it "does not contain articles that are not ready to publish" do
        unpublished = FactoryGirl.create(:post, release_date: Time.now, publish_ready: false)
        published = FactoryGirl.create(:post, title: "Published Title", release_date: Time.now)
        get :index
        assigns(:articles).count.should eq(1)
        assigns(:articles).first.title.should eq("Published Title")
      end
    end

    context "Atom feed" do

      it "generates Atom feed" do
        get :index, :format => :atom
        response.should be_success
      end
    end

  end

  describe "GET show" do
    context "without a signed in admin" do
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

      it "increments read_count by 1" do
        article = FactoryGirl.create(:post)
        get :show, id: article
        assigns(:article).read_count.should eq(1)
      end

      it "increments the read_count multiple times" do
        article = FactoryGirl.create(:post)
        3.times { get :show, id: article }
        assigns(:article).read_count.should eq(3)
      end
    end

    context "with a signed in admin" do
      before do
        admin = FactoryGirl.create(:admin)
        sign_in admin
      end
      it "does not increment the read_count" do
        article = FactoryGirl.create(:post)
        get :show, id: article
        assigns(:article).read_count.should eq(0)
      end

    end

  end
end
