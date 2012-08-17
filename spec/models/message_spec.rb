require 'spec_helper'

describe Message do
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
end
