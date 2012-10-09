require 'spec_helper'

describe Message do

	context "without a static_body" do
		it "has a valid factory" do
			FactoryGirl.build(:message).should be_valid
		end

		it "is invalid without a name" do
			FactoryGirl.build(:message, name: nil).should_not be_valid
		end
	 
		it "is invalid without an email" do
			FactoryGirl.build(:message, email: nil).should_not be_valid
		end

		it "is invalid without a message body" do
			FactoryGirl.build(:message, body: nil).should_not be_valid
		end

		it "is invalid without a properly formatted email" do
			FactoryGirl.build(:message, email: "david@").should_not be_valid
		end

		it "is valid with a subject" do
			FactoryGirl.build(:message, subject: "The subject").should be_valid
		end

	end

	context "with a static_body" do
		it "is valid with only email" do
			FactoryGirl.build(:message, static_body: "Test", body: nil, name: nil).should be_valid
		end

		it "is invalid without an email" do
			FactoryGirl.build(:message, static_body: "Test", body: nil, name: nil, email: nil).should_not be_valid
		end

		it "is invalid without properly formatted email" do
			FactoryGirl.build(:message, static_body: "Test", body: nil, name: nil, email: "david@").should_not be_valid
		end
	end

	context "with optional subject" do

		it "has default subject" do
			email = ContactMailer.new_message(FactoryGirl.build(:message, subject: nil))
			email.should have_subject "Form submitted from #{DevblogExtensions::WEBSITE_URL}."
		end

		it "has custom subject" do
			email = ContactMailer.new_message(FactoryGirl.build(:message, subject: "Custom Subject"))
			email.should have_subject "Custom Subject"
		end

	end

end
