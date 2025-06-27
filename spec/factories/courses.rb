FactoryBot.define do
  factory :course do
    name { Faker::Educator.course_name }
    description { Faker::Lorem.paragraph }
    duration_hours { rand(10..100) }
    
    trait :with_tutors do
      after(:create) do |course|
        create_list(:tutor, 2, course: course)
      end
    end
  end
end
