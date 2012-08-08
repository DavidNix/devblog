FactoryGirl.define do
	factory :post do
		title { Faker::Lorem.words(devblog_rand(10)).join(" ") }

		teaser { Faker::Lorem.sentences(devblog_rand(5)).join(" ") }
		content { Faker::Lorem.paragraphs(devblog_rand(10) ).join("\n") }

		permalink { Faker::Lorem.words(devblog_rand(10)).join("-") }

		release_date { Time.random_date }

	end		
end

# == Schema Information
#
# Table name: posts
#
#  id           :integer         not null, primary key
#  title        :string(255)
#  release_date :datetime
#  teaser       :text(255)
#  content      :text
#  permalink    :string(255)
#  created_at   :datetime        not null
#  updated_at   :datetime        not null
#