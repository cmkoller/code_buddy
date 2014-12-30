FactoryGirl.define do

  factory :user do
    sequence(:email) { |n| "personemailllll#{n}@example.com" }
    password "password"
  end

  factory :resource do
    title "Whatever title"
    description "Whatever description lalalala"
    url "http://www.whatever.com"
  end
end
