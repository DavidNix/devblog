require 'spec_helper'

describe ContactController do

  describe "GET new" do
    it "assigns a new mesage to @message" do
      get :new
      # is_a_new calls record_new? which isn't available on a Message model
      assigns(:message).is_a?(Message).should == true
    end

    it "renders the :new template" do
      get :new
      response.should render_template :new
    end
  end

  describe "POST create" do

    describe "full email message" do
      context "with valid information" do
        let (:message_attributes) { FactoryGirl.attributes_for(:message) }
        it "creates a new message" do
          post :create, message: message_attributes
          assigns(:message).attributes.symbolize_keys.should eq(message_attributes)
        end

        it "redirects to contact path" do
          post :create, message: message_attributes
          response.should redirect_to contact_path
        end

        it "creates an email message" do
          post :create, message: message_attributes
          ActionMailer::Base.deliveries.count.should > 0
        end

      end

      context "with invalid information" do
        let (:message_attributes) { FactoryGirl.attributes_for(:message, email: nil, name: nil, body: nil) }
        it "redirects to the new template" do
          post :create, message: message_attributes
          response.should render_template :new
        end

        it "has errors" do
          post :create, message: message_attributes
          assigns(:message).errors.messages.count.should > 0
        end
      end

      describe "email only message" do

      end

    end

  end

end