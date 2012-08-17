FactoryGirl.define do
	factory :message do

		email { Faker::Internet.email }
		name { Faker::Name.name }
		message_body { Faker::Lorem.sentences(devblog_rand(10) ).join(" ") }

	end		
end