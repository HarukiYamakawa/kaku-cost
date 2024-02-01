FactoryBot.define do
  factory :product do
    name { Faker::Lorem.characters(number: rand(5..15)) }
    price { Faker::Number.number(digits: 2) }
    stock { Faker::Number.number(digits: 2) }
    description { Faker::Lorem.paragraph }
    image_url { Faker::Lorem.word }
  end
end
