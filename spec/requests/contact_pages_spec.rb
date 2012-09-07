require 'spec_helper'

describe "Contact pages" do

	subject { page }

	describe "send a general contact message" do
		context "with invalid information" do
			before do
				visit contact_url
				fill_in "Name", with: ""
				fill_in "Email", with: ""
				fill_in "message_body", with: ""
				click_button "Send Message"
			end
			it { should have_selector('div.alert.alert-error') }
			it { should_not have_content "does not appear to be valid" }
			it { should have_selector('title', text: full_title('Contact')) }
		end

		context "with invalid email" do
			let (:message) { FactoryGirl.build(:message) }
			before do
				visit contact_url
				fill_in "Name", with: message.name
				fill_in "Email", with: "david@"
				fill_in "message_body", with: message.body
				click_button "Send Message"
			end
			it { should have_selector('div.alert.alert-error', text: "Please review the problems below:") }
			it { should have_content "does not appear to be valid" }
		end

		context "with valid information" do
			let (:message) { FactoryGirl.build(:message) }
			before do
				visit contact_url
				fill_in "Name", with: message.name
				fill_in "Email", with: message.email
				fill_in "message_body", with: message.body
				click_button "Send Message"
			end
			it { should have_selector('div.alert.alert-success', text: "Message was successfully sent.") }

			it "sends a valid email" do

				open_last_email.should be_delivered_to DevblogExtensions::CONTACT_DELIVERY_TO_EMAIL
        		open_last_email.should have_body_text message.body
        		open_last_email.should be_delivered_from "#{message.name} <#{message.email}>"
    		end

		end

	end

end