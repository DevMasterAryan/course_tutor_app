FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "user#{n}@#{Faker::Internet.domain_name}" }
    password { 'password123' }
    password_confirmation { 'password123' }
  end
end
