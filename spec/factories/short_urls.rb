# == Schema Information
#
# Table name: short_urls
#
#  id             :bigint           not null, primary key
#  title          :string
#  url            :string
#  visits_counter :integer          default(0)
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  encoded_id     :string
#
# Indexes
#
#  index_short_urls_on_encoded_id  (encoded_id) UNIQUE
#

FactoryBot.define do
  factory :short_url do
    url { Faker::Internet.url }
    visits_counter { rand(1..1000) }
  end
end
