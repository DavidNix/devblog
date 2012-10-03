FactoryGirl.define do
	factory :message do

		email { Faker::Internet.email }
		name { Faker::Name.name }
		body { Faker::Lorem.sentences(devblog_rand(10) ).join(" ") }
		subject nil
		static_body nil
	end		
end