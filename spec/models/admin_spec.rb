require 'spec_helper'

describe Admin do
	it "has a valid factory" do
		FactoryGirl.create(:admin).should be_valid
	end

	it "is invalid without an email" do
		FactoryGirl.build(:admin, email: nil).should_not be_valid
	end
 
	it "is invalid without password" do
		FactoryGirl.build(:admin, password: nil).should_not be_valid
	end

	it "is invalid with duplicate emails" do
		fake_email = "david@faKe.com"
		FactoryGirl.create(:admin, email: fake_email)
		FactoryGirl.build(:admin, email: fake_email.upcase).should_not be_valid
	end

end

# == Schema Information
#
# Table name: admins
#
#  id                     :integer         not null, primary key
#  email                  :string(255)     default(""), not null
#  encrypted_password     :string(255)     default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer         default(0)
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  created_at             :datetime        not null
#  updated_at             :datetime        not null
#

