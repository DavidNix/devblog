FactoryGirl.define do
	factory :admin do
		email { Faker::Internet.email }
		sequence(:password) { |n| "testpassword#{n}" }
		password_confirmation { |adm| adm.password }
	end		
end