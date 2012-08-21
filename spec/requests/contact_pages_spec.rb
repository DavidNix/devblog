require 'spec_helper'

describe "Contact pages" do

	subject { page }

	describe "send a general contact message" do
		context "with invalid information" do
			before do
				visit contact_path
				fill_in "Name", with: ""
				fill_in "Email", with: ""
				fill_in "message_body", with: ""
				click_button "Send"
			end
			it { should have_selector('div#error_explanation') }
		end

		context "with invalid email" do
			let (:message) { FactoryGirl.build(:message) }
			before do
				visit contact_path
				fill_in "Name", with: message.name
				fill_in "Email", with: "david@"
				fill_in "message_body", with: message.body
				click_button "Send"
			end
			it { should have_selector('div#error_explanation', text: "Email address does not appear to be valid") }
			it { should_not have_selector('div#error_explanation', text: "Email address can't be blank") }
		end

		context "with valid information" do
			let (:message) { FactoryGirl.build(:message) }
			before do
				visit contact_path
				fill_in "Name", with: message.name
				fill_in "Email", with: message.email
				fill_in "message_body", with: message.body
				click_button "Send"
			end
			it { should have_selector('div.alert.alert-success', text: "Message was successfully sent.") }
		end

	end

end