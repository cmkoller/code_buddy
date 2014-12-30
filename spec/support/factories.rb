FactoryGirl.define do
  #
  # sequence :email do |n|
  #   "email#{n}@example.com"
  # end


  factory :user do
    sequence(:email) { |n| "personemailllll#{n}@example.com" }
    display_name "Bob"
    password "password"
  end

end
