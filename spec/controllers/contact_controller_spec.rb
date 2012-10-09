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
  end

  describe "POST create_email_only" do
    context "with valid information" do

      let (:message_attributes) { FactoryGirl.attributes_for(:message, email: "d@test.com", subject: "test subject", name: nil, body: nil, static_body: "Test Static Body") }
      
      it "creates a new message" do
        post :create_email_only, message: message_attributes, origin_url: root_url
        assigns(:message).attributes.symbolize_keys.should eq(message_attributes)
      end

      it "redirects to origin url" do
        post :create_email_only, message: message_attributes, origin_url: root_url
        response.should redirect_to root_url
      end

      it "creates an email message" do
        post :create_email_only, message: message_attributes, origin_url: root_url
        ActionMailer::Base.deliveries.count.should > 0
      end

      # test it here because the partial can be put on any page
      it "sends the expected email" do
        post :create_email_only, message: message_attributes, origin_url: root_url

        open_last_email.should be_delivered_to DevblogExtensions::CONTACT_DELIVERY_TO_EMAIL
        open_last_email.should have_body_text message_attributes[:static_body]
        open_last_email.should be_delivered_from message_attributes[:email]
        open_last_email.should have_subject message_attributes[:subject]
      end

    end

    context "with invalid information" do
      let (:message_attributes) { FactoryGirl.attributes_for(:message, email: nil, name: nil, body: nil, static_body: "Test") }

      it "redirects to the origin url" do
        post :create_email_only, message: message_attributes, origin_url: root_url
        response.should redirect_to root_url
      end

      it "has errors" do
        post :create_email_only, message: message_attributes, origin_url: root_url
        assigns(:message).errors.messages.count.should > 0
      end

    end

  end

end