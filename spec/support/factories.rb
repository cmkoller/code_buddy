FactoryGirl.define do

  factory :user do
    sequence(:email) { |n| "personemailllll#{n}@example.com" }
    display_name "Bob"
    password "password"
  end

  factory :admin, class: User do
    sequence(:email) { |n| "personemailllll#{n}@example.com" }
    display_name "Mr. Admin"
    password "password"
    admin true
  end

  factory :buddy do
    title "Whatever title"
    description "Whatever description lalalala"
    url "http://www.whatever.com"
    user
  end
end
