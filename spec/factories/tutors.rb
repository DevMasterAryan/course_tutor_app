FactoryBot.define do
  factory :tutor do
    name { Faker::Name.name }
    sequence(:email) { |n| "tutor#{n}@#{Faker::Internet.domain_name}" }
    phone { Faker::PhoneNumber.phone_number }
    experience_years { rand(0..20) }
    association :course
  end
end
